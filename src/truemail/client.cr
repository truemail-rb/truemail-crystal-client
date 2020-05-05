module Truemail
  module Client
    def self.validate(email : String, configuration : Truemail::Client::Configuration)
      raise Exception.new(Truemail::Client::Configuration::INCOMPLETE_CONFIG) if configuration.not_complete?

      Truemail::Client::Http.new(**configuration.settings).run(email)
    end
  end
end
