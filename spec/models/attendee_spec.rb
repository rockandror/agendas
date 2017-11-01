require 'rails_helper'

RSpec.describe Attendee, type: :model do

  let(:attendee) { build(:attendee) }

  it "should be valid" do
    expect(attendee).to be_valid
  end

  it "should be invalid if no name" do
    attendee.name = nil

    expect(attendee).not_to be_valid
  end

  it "should be invalid if no company" do
    attendee.company = nil

    expect(attendee).not_to be_valid
  end

  it "should be invalid if no position" do
    attendee.position = nil

    expect(attendee).not_to be_valid
  end

end
