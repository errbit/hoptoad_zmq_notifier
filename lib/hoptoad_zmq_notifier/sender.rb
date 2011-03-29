# encoding: utf-8
require 'ffi'
require 'ffi-rzmq'

module HoptoadZmqNotifier
  class Sender
    def send_to_hoptoad data
      logger.debug { "Sending request to #{@uri}:\n#{data}" } if logger
      socket.send_string data, ZMQ::NOBLOCK
    end

    def initialize(options = {})
      [:mailbox_size, :uri].each do |option|
        instance_variable_set("@#{option}", options[option])
      end
    end

    private
    def logger
      HoptoadNotifier.logger
    end

    def socket
      @socket ||= HoptoadZmqNotifier.configuration.socket
    end
  end
end
