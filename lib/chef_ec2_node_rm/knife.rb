module ChefEc2NodeRm
  class Knife
    include Logging

    def initialize(command)
      @command = "knife #{command} --format json"
    end

    def run
      logger.debug("Knife command: #{@command}")
      result = `#{@command}`
      result_parsed = begin
        JSON.parse(result)
      rescue JSON::ParserError
        result
      end
      logger.debug("Knife output: #{result_parsed}")
      result_parsed
    end
  end
end
