module RequestHelper
  struct Request
    getter secure_connection, host, port, token, method, email, accept, content_type, user_agent

    def initialize(
      @secure_connection : Bool,
      @host : String,
      @port : Int32,
      @token : String,
      @method : Symbol,
      @email : String,
      @accept : String,
      @content_type : String,
      @user_agent : String
    )
    end
  end

  def have_sent_request_with(**request_settings)
    request = RequestHelper::Request.new(**request_settings)
    url = "#{request.secure_connection ? "https" : "http"}://#{request.host}:#{request.port}/?email=#{request.email}"

    WebMock.stub(request.method, url).with(
      headers: {
      "Accept" => request.accept,
      "Authorization" => request.token,
      "Content-Type" => request.content_type,
      "Host" => "#{request.host}:#{request.port}",
      "User-Agent" => request.user_agent
      }
    ).to_return(
      status: 200,
      body: truemail_json_response(request.email),
      headers: HTTP::Headers{ "Content-Type" => request.content_type }
    )
  end

  def truemail_json_response(email)
    {
      configuration: {
        blacklisted_domains: nil,
        email_pattern: "default gem value",
        smtp_error_body_pattern: "default gem value",
        smtp_safe_check: true,
        validation_type_by_domain: nil,
        whitelist_validation: false,
        whitelisted_domains: nil
      },
      date: Time.local,
      email: email,
      errors: nil,
      smtp_debug: nil,
      success: true,
      validation_type: "smtp"
    }.to_json
  end
end
