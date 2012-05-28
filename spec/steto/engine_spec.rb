require 'spec_helper'

describe Steto::Engine do

  describe "#check" do

    it "should check every check" do
      3.times do
        subject.checks << check = mock
        check.should_receive :check
      end
      subject.check
    end

  end

  describe "#config" do
    
    context "without block" do
      
      it "should return the engine Config" do
        subject.config.engine.should == subject
      end

    end

    context "with block" do
      
      it "should configure with block" do
        subject.config.should_receive(:configure).and_yield
        subject.config { }
      end

    end
    
  end

  describe "#report" do

    before(:each) do
      subject.stub :checks => "checks"
    end

    let(:reporter) { mock } 
    
    context "with a reporter is given" do

      it "should create report with it" do
        reporter.should_receive(:report).with(subject.checks)
        subject.report reporter
      end
                                         
    end

    context "without argument" do

      it "should use all predefined reporters" do
        subject.reporters << reporter
        reporter.should_receive(:report).with(subject.checks)
        subject.report
      end
                                 
    end

  end

end
