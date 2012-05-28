require 'spec_helper'

describe Steto::LoggerReporter do

  def check(status, attributes = {})
    attributes = { 
      :name => "dummy", 
      :text => "Dummy check", 
      :status => Steto::Status.new(status) 
    }.merge(attributes)

    mock attributes
  end

  it "should log in warn the warning checks" do
    subject.logger.should_receive(:warn)
    subject.report [ check(:warning) ]
  end

  it "should log in error the critical checks" do
    subject.logger.should_receive(:error)
    subject.report [ check(:critical) ]
  end

  it "should log in debug the ok/unknown checks" do
    subject.logger.should_receive(:debug)
    subject.report [ check(:ok) ]
  end

  it "should include name and status in message" do
    subject.logger.should_receive(:debug).with("dummy is ok")
    subject.report [ check(:ok, :name => "dummy", :text => nil) ]
  end

  it "should include text when available in message" do
    subject.logger.should_receive(:debug).with("dummy is ok: text")
    subject.report [ check(:ok, :name => "dummy", :text => "text") ]
  end

end
