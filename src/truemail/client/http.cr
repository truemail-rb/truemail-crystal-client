require "http/client"

module Truemail
  module Client
    class Http
      USER_AGENT   = "Truemail Crystal client"
      MIME_TYPE    = "application/json"

      getter host, token, port, secure_connection

      def initialize(
        @secure_connection : Bool,
        @host : String,
        @port : Int32,
        @token : String
      )
      end

      def run(email)
        HTTP::Client.get(uri(email), headers).body
      rescue error
        { truemail_client_error: error.message }.to_json
      end

      private def uri(email)
        "#{secure_connection ? "https" : "http"}://#{host}:#{port}?email=#{email}"
      end

      private def headers
        HTTP::Headers{
          "User-Agent"    => Truemail::Client::Http::USER_AGENT,
          "Accept"        => Truemail::Client::Http::MIME_TYPE,
          "Content-Type"  => Truemail::Client::Http::MIME_TYPE,
          "Authorization" => token,
        }
      end
    end
  end
end
