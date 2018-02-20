module ChefEc2NodeRm
  module Logging
    def logger
      Logging.logger
    end

    def self.logger
      @logger ||= Logger.new(@device || STDOUT)
    end

    def logger_device(device)
      Logging.logger_device(device)
    end

    def self.logger_device(device)
      @device = device
    end
  end
end
