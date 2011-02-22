# encoding: utf-8
require 'spec_helper'

describe HoptoadNotifierZmq::Sender do
  before(:each) do
    @uri = "tcp://127.0.0.1:9999"
    @message = "samplte message"
    HoptoadNotifierZmq.configure do |config|
      config.uri = @uri
    end
  end

  it "should send messages via 0MQ" do
    HoptoadNotifier.sender.send_to_hoptoad(@message)

    #HoptoadNotifierZmq.configuration.zmq_context.terminate
    ctx = ZMQ::Context.new
    s = ctx.socket ZMQ::PULL
    #s.setsockopt(ZMQ::HWM, 100)
    s.bind(@uri)
    s.recv_string.should == @message
  end
end
