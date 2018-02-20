require 'aws-sdk-sqs'
require 'chef/knife'
require 'json'
require 'logger'
require 'pp'

require "chef_ec2_node_rm/error"
require "chef_ec2_node_rm/logging"
require "chef_ec2_node_rm/meta"
require "chef_ec2_node_rm/sqs_message"
require "chef_ec2_node_rm/sqs_pollers"
