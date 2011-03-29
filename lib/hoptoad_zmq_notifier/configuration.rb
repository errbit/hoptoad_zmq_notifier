# encoding: utf-8
module HoptoadZmqNotifier
  # Used to set up and modify settings for the notifier.
  class Configuration

    OPTIONS = [:mailbox_size, :uri].freeze

    # Size of outgoing messages queue. All messages over this value will be dropped.
    attr_accessor :mailbox_size

    # The uri to connect to (0MQ socket)
    attr_accessor :uri

    def initialize
      @mailbox_size = 200
    end

    def zmq_context
      @zmq_context ||= ZMQ::Context.new
    end

    def socket
      @socket ||= begin
        s = zmq_context.socket ZMQ::PUB
        s.connect @uri
        s.setsockopt(ZMQ::HWM, mailbox_size)
        at_exit { s.close }
        s
      end
    end

    # Allows config options to be read like a hash
    #
    # @param [Symbol] option Key for a given attribute
    def [](option)
      send(option)
    end

    # Returns a hash of all configurable options
    def to_hash
      OPTIONS.inject({}) do |hash, option|
        hash.merge(option.to_sym => send(option))
      end
    end

    # Returns a hash of all configurable options merged with +hash+
    #
    # @param [Hash] hash A set of configuration options that will take precedence over the defaults
    def merge(hash)
      to_hash.merge(hash)
    end
  end
end
