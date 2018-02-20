$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'chef_ec2_node_rm'

include ChefEc2NodeRm::Logging
logger_device('/dev/null')

require 'minitest/autorun'
