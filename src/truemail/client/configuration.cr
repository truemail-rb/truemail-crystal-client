module Truemail
  module Client
    class Configuration
      INCOMPLETE_CONFIG = "required args not passed"
      DEFAULT_PORT = 9292
      DEFAULT_VALUE = "not_configured"

      property secure_connection : Bool = false,
               host : String = Truemail::Client::Configuration::DEFAULT_VALUE,
               port : Int32 = Truemail::Client::Configuration::DEFAULT_PORT,
               token : String = Truemail::Client::Configuration::DEFAULT_VALUE

      def initialize(&block : Truemail::Client::Configuration -> Bool | String | Int32)
        tap(&block)
      end

      def settings
        {
          secure_connection: secure_connection,
          host: host,
          port: port,
          token: token
        }
      end

      def not_complete?
        settings.values.includes?(Truemail::Client::Configuration::DEFAULT_VALUE)
      end
    end
  end
end
