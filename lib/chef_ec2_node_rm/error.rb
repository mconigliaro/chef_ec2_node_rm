module ChefEc2NodeRm
  class Error < StandardError; end

  class SqsMessageError < Error; end
  class SqsMessageMalformedJson < SqsMessageError; end
  class SqsMessageNotHash < SqsMessageError; end
  class SqsMessageMissingAttribute < SqsMessageError; end
end
