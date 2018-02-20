module ChefEc2NodeRm
  class SqsMessage
    include Logging

    attr_reader :instance_id, :state

    def initialize(msg)
      msg_parsed = JSON.parse(msg)
      raise SqsMessageNotHash, "Expected a Hash but got a #{msg_parsed.class}" unless msg_parsed.is_a?(Hash)

      attr_map = {
        instance_id: ['detail', 'instance-id'],
        state: ['detail', 'state']
      }
      attr_map.each do |name, path|
        value = msg_parsed.dig(*path)
        raise ChefEc2NodeRm::SqsMessageMissingAttribute, "Missing value for #{name} (msg='#{msg}', path='#{path.join('.')}')" if value.nil?
        instance_variable_set("@#{name}", value)
      end
    rescue JSON::ParserError => e
      raise ChefEc2NodeRm::SqsMessageMalformedJson, "Malformed JSON: #{e}"
    end
  end
end
