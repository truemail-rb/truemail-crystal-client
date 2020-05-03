module Truemail
  module Client
    class Configuration
      DEFAULT_PORT = 9292

      property secure_connection : Bool = false,
               host : String | Nil = nil,
               port : Int32 = Truemail::Client::Configuration::DEFAULT_PORT,
               token : String | Nil = nil

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

      def complete?
        settings.values.none?(&.nil?)
      end
    end
  end
end
