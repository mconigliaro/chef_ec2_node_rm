module ChefEc2NodeRm
  class SqsPollers
    include Logging

    attr_reader :pollers

    def initialize(urls)
      @pollers = urls.map do |url|
        begin
          logger.debug(url) { "Verifying queue" }
          # Each queue is verified by making a request for its attributes. An
          # exception should get raised for any queue that is non-existent or
          # otherwise unavailable.
          Aws::SQS::Queue.new(url).attributes
          Aws::SQS::QueuePoller.new(url)
        rescue Aws::Errors::ServiceError => e
          logger.error(url) { "#{e.message} (ignoring)" }
          nil
        end
      end.compact
    end

    def start(dry_run: false, &block)
      trap('SIGINT') do
        Thread.new do
          logger.info('Shutting down')
          exit
        end
      end
      @pollers.map do |poller|
        Thread.new do
          Thread.current.name = poller.queue_url
          logger.info(Thread.current.name) { "Starting poller#{' (dry-run)' if dry_run}" }
          poller.poll(skip_delete: true) { |msg| yield(poller, msg) }
        end
      end.each(&:join)
      logger.info('No queues left to poll')
    end
  end
end
