# encoding: utf-8
require 'hoptoad_notifier'
module HoptoadZmqNotifier
  autoload :Configuration, 'hoptoad_zmq_notifier/configuration'
  autoload :Sender, 'hoptoad_zmq_notifier/sender'
  class << self
    # The sender object is responsible for delivering formatted data to the Hoptoad server.
    # Must respond to #send_to_hoptoad. See HoptoadNotifier::Sender.
    attr_accessor :sender

    # A Hoptoad Notifier ZMQ configuration object. Must act like a hash and return sensible
    # values for all Hoptoad ZMQ configuration options. See HoptoadNotifierZmq::Configuration.
    attr_accessor :configuration

    # Call this method to modify defaults in your initializers.
    #
    # @example
    #   HoptoadNotifierZmq.configure do |config|
    #     config.mailbox_sizr = 1000
    #     config.uri  = 'tcp://errbit.home:9999'
    #   end
    def configure
      self.configuration ||= Configuration.new
      yield(configuration)
      self.sender = Sender.new(configuration)
    end
  end
end

HoptoadNotifier.configure do |config|
end

module HoptoadNotifier
  class Sender
    def send_to_hoptoad *args
      HoptoadNotifierZmq.sender.send_to_hoptoad(*args)
    end
  end
end
