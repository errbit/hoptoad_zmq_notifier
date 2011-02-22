# encoding: utf-8
require 'ffi'
require 'ffi-rzmq'

module HoptoadNotifierZmq
  class Sender
    def send_to_hoptoad data
      logger.debug { "Sending request to #{uri}:\n#{data}" } if logger
      socket.send_string data
    end

    def initialize(options = {})
      [:mailbox_size].each do |option|
        instance_variable_set("@#{option}", options[option])
      end
    end

    private
    def logger
      HoptoadNotifier.logger
    end

    def socket
      @socket ||= HoptoadNotifierZmq.configuration.socket
    end
  end
end
