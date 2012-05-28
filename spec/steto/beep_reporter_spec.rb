require 'spec_helper'

describe Steto::BeepReporter do

  it "should beep twice when one of checks is critical" do
    subject.should_receive(:beep).with(2)
    subject.report [ mock :status => Steto::Status.new(:critical) ]
  end

  it "should beep when one of checks is warning" do
    subject.should_receive(:beep)
    subject.report [ mock :status => Steto::Status.new(:warning) ]
  end

  it "should not beep when no check is warning or critical" do
    subject.should_not_receive(:beep)
    subject.report [ mock :status => Steto::Status.new(:info) ]
  end

end
