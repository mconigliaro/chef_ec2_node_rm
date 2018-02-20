require 'test_helper'

describe 'ChefEc2NodeRmTest' do
  def test_that_it_has_a_version_number
    refute_nil ChefEc2NodeRm::VERSION
  end
end

describe 'ChefEc2NodeRmTest::Knife' do
  it 'performs a node search' do
    results = ChefEc2NodeRm::Knife.new("search node '*:*' --id-only").run

    assert results.key?('results')
    assert_kind_of Numeric, results['results']

    assert results.key?('rows')
    assert_respond_to results['rows'], :each
  end
end

describe 'ChefEc2NodeRmTest::SqsMessage' do
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
