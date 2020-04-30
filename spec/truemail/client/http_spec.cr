require "../../spec_helper"

Spectator.describe Truemail::Client::Http do
  include RequestHelper

  let(:host) { "example.com" }
  let(:token) { "some_token" }
  let(:port) { 8080 }

  describe "defined constants" do
    it { expect(Truemail::Client::Http::DEFAULT_PORT).to be_an_instance_of(Int32) }
    it { expect(Truemail::Client::Http::USER_AGENT).to be_an_instance_of(String) }
    it { expect(Truemail::Client::Http::MIME_TYPE).to be_an_instance_of(String) }
  end

  describe ".new" do
    context "with default params values" do
      subject(:http_instance) { described_class.new(host: host, token: token) }

      it "returns http instance with default values" do
        expect(http_instance.host).to eq(host)
        expect(http_instance.token).to eq(token)
        expect(http_instance.port).to eq(Truemail::Client::Http::DEFAULT_PORT)
        expect(http_instance.secure_connection).to be(false)
      end
    end

    context "with custom params values" do
      subject(:http_instance) do
        described_class.new(host: host, token: token, port: port, secure_connection: secure_connection)
      end

      let(:secure_connection) { true }

      it "returns http instance with custom values" do
        expect(http_instance.host).to eq(host)
        expect(http_instance.token).to eq(token)
        expect(http_instance.port).to eq(port)
        expect(http_instance.secure_connection).to be(secure_connection)
      end
    end
  end

  describe "#run" do
    subject(:run) do
      described_class.new(
        host: host,
        port: port,
        token: token,
        secure_connection: secure_connection
      ).run(email)
    end

    let(:secure_connection) { true }
    let(:email) { "some_email@example.com" }

    context "when connection successful" do
      let(:app_type) { "application/json" }
      let(:request_settings) do
          {
            method: :get,
            accept: app_type,
            content_type: app_type,
            user_agent: "Truemail Crystal client",
            email: email,
            host: host,
            port: port,
            token: token,
            secure_connection: secure_connection
          }
        end

      context "when secure connection" do
        it "sends valid request to truemail api, returns json response" do
          have_sent_request_with(**request_settings)
          expect(run).to eq(truemail_json_response(email))
        end
      end

      context "when not secure connection" do
        let(:secure_connection) { false }

        it "sends valid request to truemail api, returns json response" do
          have_sent_request_with(**request_settings)
          expect(run).to eq(truemail_json_response(email))
        end
      end
    end

    context "when connection fails" do
      mock HTTP::Client do
        stub self.get(url : String | URI, headers : HTTP::Headers? = nil)
      end

      let(:error) { "some error context" }

      it "returns json with client error message" do
        client, exception = HTTP::Client, Exception.new(error)
        allow(client).to receive(:get).and_raise(exception)
        expect(run).to eq("{\"truemail_client_error\":\"#{error}\"}")
      end
    end
  end
end
