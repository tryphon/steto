require 'spec_helper'

describe Steto::BaseCheck do

  subject do 
    Steto::BaseCheck.new.tap do |check|
      check.stub :check
    end
  end

  describe "#to_json" do

    it "should include name" do
      subject.name = "dummy"
      JSON.parse(subject.to_json).should include("name" => "dummy")
    end

    it "should include text" do
      subject.text = "dummy"
      JSON.parse(subject.to_json).should include("text" => "dummy")
    end

    it "should include status" do
      subject.status = :critical
      JSON.parse(subject.to_json).should include("status" => "critical")
    end

  end

end
