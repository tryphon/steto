require 'spec_helper'

describe Steto::ProcCheck do

  describe "#status_from_response" do
    
    it "should return ok when response is true" do
      subject.status_from_response(true).should be_ok
    end

    it "should return critical when response is false" do
      subject.status_from_response(false).should be_critical
    end

    it "should return unknown when response is nil" do
      subject.status_from_response(nil).should be_unknown
    end

    it "should return a Status when response is Symbol" do
      subject.status_from_response(:ok).should be_ok
    end

    it "should return the response when it is a Status" do
      subject.status_from_response(Steto::Status.new(:ok)).should be_ok
    end

  end
  

end
