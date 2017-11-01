require 'rails_helper'

RSpec.describe Event, type: :model do

  let(:event) { build(:event) }

  it "should be invalid without title" do
    event.title = nil

    expect(event).not_to be_valid
  end

  it "should be invalid without position" do
    event.position = nil

    expect(event).not_to be_valid
  end

  it "should be invalid when" do
    event.position = nil

    expect(event).not_to be_valid
  end

  it "should be invalid if participant are not unique" do
    participant = create :participant
    event.participants << participant
    event.participants << participant

    expect(event).not_to be_valid
  end

  it "should not be allowed assign participant more than once to event" do
  end

end