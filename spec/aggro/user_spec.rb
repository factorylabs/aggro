require 'spec_helper'

describe Aggro::User do
  subject { Aggro::User.new(params) }

  describe "#twitter" do
    let(:params) { {instagram: ""} }

    context "with twitter handle on initialize" do
      let(:params) { { twitter: "heimidal"} }
      its(:twitter) { should eq "heimidal" }
    end

    context "without a twitter handle" do
      its(:twitter) { should eq "" }
    end

    it "lets you set it explicitly" do
      subject.twitter = "factorylabs"
      expect(subject.twitter).to eq "factorylabs"
    end
  end

  describe "#instagram" do
    let(:params) { {twitter: ""} }

    context "with instagram handle on initialize" do
      let(:params) { { instagram: "heimidal"} }
      its(:instagram) { should eq "heimidal" }
    end

    context "without a twitter handle" do
      its(:instagram) { should eq "" }
    end

    it "lets you set it explicitly" do
      subject.instagram = "factorylabs"
      expect(subject.instagram).to eq "factorylabs"
    end
  end

  describe "initialization with no services" do
    let(:params) { {} }

    it "should raise an ArgumentError" do
      expect { subject }.to raise_error(ArgumentError, "must specify a supported service: instagram, twitter")
    end
  end
end
