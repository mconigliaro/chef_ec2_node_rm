module ChefEc2NodeRm
  class SqsPollers
    include Logging

    attr_reader :pollers

    def initialize(urls)
      @pollers = urls.map do |url|
        begin
          logger.debug(url) { 'Verifying queue' }
          # Each queue is verified by making a request for its attributes. An
          # exception should get raised for any queue that is non-existent or
          # otherwise unavailable.
          Aws::SQS::Queue.new(url).attributes
          Aws::SQS::QueuePoller.new(url)
        rescue Aws::Errors::ServiceError => e
          logger.error(url) { e.message }
          nil
        end
      end.compact
    end

    def start
      trap('SIGINT') { Thread.new { exit } }
      @pollers.map do |poller|
        Thread.new do
          Thread.current.name = poller.queue_url
          logger.info(Thread.current.name) { 'Starting poller' }
          poller.poll(skip_delete: true) do |msg|
            logger.debug(Thread.current.name) { %(Message received: id='#{msg.message_id}' body='#{msg.body.delete("\n")}') }
            yield(poller, msg)
          end
        end
      end.each(&:join)
      logger.info('No queues left to poll')
    end
  end
end
