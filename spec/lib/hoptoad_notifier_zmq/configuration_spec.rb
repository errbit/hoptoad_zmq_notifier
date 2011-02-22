# encoding: utf-8
require 'spec_helper'

describe HoptoadNotifierZmq::Configuration do
  it "should provide default mailbox size" do
    assert_config_default :mailbox_size, 200
  end

  it "should mailbox size to be overitten" do
    assert_config_overridable :mailbox_size
  end

  it "should have an uri" do
    assert_config_overridable :uri
  end
end

def assert_config_overridable(option, value = 'a value')
  config = HoptoadNotifierZmq::Configuration.new
  config.send(:"#{option}=", value)
  config.send(option).should == value
end

def assert_config_default(option, default_value, config = nil)
  config ||= HoptoadNotifierZmq::Configuration.new
  config.send(option).should == default_value
end
