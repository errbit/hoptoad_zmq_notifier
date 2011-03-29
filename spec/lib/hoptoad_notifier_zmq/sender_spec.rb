# encoding: utf-8
require 'spec_helper'

describe HoptoadZmqNotifier::Sender do
  before(:each) do
    @uri = "tcp://127.0.0.1:9998"
    @message = "sample message"
    @mailbox_size = 35
    HoptoadZmqNotifier.configure do |config|
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
    sleep 0.1
    @subscriber.recv_string(ZMQ::NOBLOCK).should == @message
  end
end
