# chef_ec2_node_rm

If you're managing EC2 instances with a Chef server, this gem can help you by automatically deleting node/client data when instances are destroyed.

## Getting Started

1. Create an SQS queue for your EC2 termination events.

1. Create a CloudWatch event rule to send termination events to the SQS queue:

    ```
    {
      "source": [
        "aws.ec2"
      ],
      "detail-type": [
        "EC2 Instance State-change Notification"
      ],
      "detail": {
        "state": [
          "terminated"
        ]
      }
    }
    ```

1. Configure `knife` on your chef server.

1. Install `chef_ec2_node_rm` on your Chef server:

    ```
    gem install chef_ec2_node_rm
    ```

1. Run the application in the foreground to make sure everything is working (run it with `--help` to see a list of available options):

    ```
    chef_ec2_node_rm <options>
    ```

1. Using the command above, create an Upstart job on your Chef server (e.g. `/etc/systemd/system/chef_ec2_node_rm.service`) to keep the application running in the background:

    ```
    [Unit]
    Description=chef_ec2_node_rm

    [Service]
    Type=simple
    Environment=HOME=/root
    ExecStart=/path/to/chef_ec2_node_rm <options>
    Restart=always

    [Install]
    WantedBy=multi-user.target
    ```

1. Start the service:

    ```
    systemctl daemon-reload
    systemctl restart chef_ec2_node_rm
    ```

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

## Releases

    gem build chef_ec2_node_rm.gemspec
    gem install chef_ec2_node_rm-*.gem

## Credits

- Inspired by [Matt Revell's script](http://blog.mattrevell.net/2014/02/19/automatically-remove-dead-autoscale-nodes-from-chef-server/)
