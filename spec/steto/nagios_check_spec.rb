require 'spec_helper'

describe Steto::NagiosCheck do

  describe "#status" do

    it "should be ok when nagios check returns OK status" do
      Steto::NagiosCheck.new(:command => "/usr/lib/nagios/plugins/check_dummy 0").status.should be_ok
    end

    it "should be warning when nagios check returns WARNING status" do
      Steto::NagiosCheck.new(:command => "/usr/lib/nagios/plugins/check_dummy 1").status.should be_warning
    end

    it "should be critical when nagios check returns CRITICAL status" do
      Steto::NagiosCheck.new(:command => "/usr/lib/nagios/plugins/check_dummy 2").status.should be_critical
    end

    it "should be unknown when nagios check returns UNKNOWN status" do
      Steto::NagiosCheck.new(:command => "/usr/lib/nagios/plugins/check_dummy 3").status.should be_unknown
    end
    
  end

  describe "#text" do

    it "should be text returned by nagios check" do
      Steto::NagiosCheck.new(:command => "/usr/lib/nagios/plugins/check_dummy 0 'additionnal text'").text.should == "OK: additionnal text"
    end

  end

  describe "#command_line" do

    it "should use command as binary" do
      subject.stub :command => "dummy"
      subject.command_line.command.should == "dummy"
    end

    it "should use options as parameters" do
      subject.stub :command => "dummy"
      subject.stub :options => { :warning => "1,0.5,0.5", :critical => "1,1,1" }
      subject.command_line.command.should == "dummy --critical='1,1,1' --warning='1,0.5,0.5'"
    end
    
  end

end
