require 'test_helper'

describe 'ChefEc2NodeRmTest::Knife' do
  it 'performs a node search' do
    results = ChefEc2NodeRm::Knife.new("search node '*:*' --id-only").run

    assert results.key?('results')
    assert_kind_of Numeric, results['results']

    assert results.key?('rows')
    assert_respond_to results['rows'], :each
  end
end
