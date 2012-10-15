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

    before do
      subject.stub :command => "dummy"
    end

    it "should use command as binary" do
      subject.command_line.command.should == "dummy"
    end

    it "should use options as parameters" do
      subject.stub :options => { :warning => "1,0.5,0.5", :critical => "1,1,1" }
      subject.command_line.command.should == "dummy --critical='1,1,1' --warning='1,0.5,0.5'"
    end

    it "should support non string options" do
      subject.stub :options => { :port => 4567 }
      begin
        subject.command_line.command.should == "dummy --port='4567'"
      rescue => e
        puts e.backtrace.join("\n")
      end
    end

    it "should rename option with underscores" do
      subject.stub :options => { :with_underscore => "yes" }
      subject.command_line.command.should == "dummy --with-underscore='yes'"
    end
    
  end

  describe "#status_from_command_line" do
    
    it "should return unknown when exitstatus is not defined" do
      subject.command_line.stub :exit_status => nil
      subject.status_from_command_line.should == :unknown
    end

  end

end
