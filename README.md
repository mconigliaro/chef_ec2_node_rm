# ChefEc2NodeRm

If you're managing EC2 instances with a Chef server, this gem can help you by automatically deleting node/client data when instances are destroyed.

Inspired by [Matt Revell's script](http://blog.mattrevell.net/2014/02/19/automatically-remove-dead-autoscale-nodes-from-chef-server/)

## Installation

    gem install chef_ec2_node_rm

## Development

### Getting Started

    ./bin/setup

### Testing

#### Running Tests

    rake test
    rake rubocop

#### Example SQS Message

    {
      "detail": {
        "instance-id": "foo",
        "state": "bar"
      }
    }
