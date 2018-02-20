require 'test_helper'

describe 'ChefEc2NodeRmTest::SqsMessage#new' do
  it 'raises an exception for invalid SQS messages' do
    assert_raises ChefEc2NodeRm::SqsMessageMalformedJson do
      ChefEc2NodeRm::SqsMessage.new('foobar')
    end
    assert_raises ChefEc2NodeRm::SqsMessageNotHash do
      ChefEc2NodeRm::SqsMessage.new('[ "foo", "bar" ]')
    end
    assert_raises ChefEc2NodeRm::SqsMessageMissingAttribute do
      ChefEc2NodeRm::SqsMessage.new('{ "foo": "bar" }')
    end
  end

  it 'parses a valid SQS message' do
    msg = '{ "detail": { "instance-id": "foo", "state": "bar" } }'
    msg_parsed = ChefEc2NodeRm::SqsMessage.new(msg)
    assert_equal 'foo', msg_parsed.instance_id
    assert_equal 'bar', msg_parsed.state
  end
end
