module ChefEc2NodeRm
  module Logging
    def logger
      Logging.logger
    end

    def self.logger
      @logger ||= Logger.new(STDOUT)
    end
  end
end