# encoding: utf-8
require 'spec_helper'

describe HoptoadNotifierZmq::Sender do
  before(:each) do
    @uri = "tcp://127.0.0.1:9998"
    @message = "sample message"
    @mailbox_size = 35
    HoptoadNotifierZmq.configure do |config|
      config.uri = @uri
      config.mailbox_size = @mailbox_size
    end

    ctx = ZMQ::Context.new
    @subscriber = ctx.socket ZMQ::SUB
    @subscriber.bind(@uri)
    @subscriber.setsockopt ZMQ::SUBSCRIBE, ""
  end

  after :each do
    @subscriber.close
  end

  it "should send messages via 0MQ" do
    HoptoadNotifier.sender.send_to_hoptoad(@message)
    sleep 1
    @subscriber.recv_string(ZMQ::NOBLOCK).should == @message
  end

  it "should keep small messages amount equal to mailbox size" do
    (@mailbox_size * 2).times { HoptoadNotifier.sender.send_to_hoptoad(@message) }
    sleep 1
    messages = []
    (@mailbox_size * 2).times {
      message = @subscriber.recv_string(ZMQ::NOBLOCK)
      messages << message if message
    }
    messages.size.should == @mailbox_size
  end
end
