require 'spec_helper'

describe Steto::Config do

  let(:engine) { Steto::Engine.new }

  subject { Steto::Config.new(engine) }

  describe "#check" do
    
    it "should use the given name for check" do
      subject.check "dummy", Steto::ProcCheck
      engine.checks.first.name.should == :dummy
    end

    it "should create a Check of given class" do
      Steto::ProcCheck.should_receive(:new).with(:name => :dummy, :key1 => "value1")
      subject.check "dummy", Steto::ProcCheck, :key1 => "value1"
    end

    it "should accept a block and create a ProcCheck" do
      subject.check("dummy") {}
      engine.checks.first.should be_an_instance_of(Steto::ProcCheck)
    end

  end

  describe "#nagios" do
    
    it "should create Steto::NagiosCheck with given command and options" do
      subject.should_receive(:check).with "dummy", Steto::NagiosCheck, :command => "/usr/lib/nagios/plugins/check_dummy", :options => { :key1 => "value1" }
      subject.nagios "dummy", "check_dummy", :key1 => "value1"
    end

  end

  describe "#report" do
    
    it "should create a Reporter of given class" do
      subject.report Steto::ProcReporter
      engine.reporters.first.should be_instance_of(Steto::ProcReporter)
    end

    it "should accept a block and create a ProcReporter" do
      subject.report {}
      engine.reporters.first.should be_instance_of(Steto::ProcReporter)
    end

  end

  describe "#configure" do

    it "should eval the given block" do
      subject.should_receive(:check)
      subject.configure do
        check
      end
    end
    
  end

end
