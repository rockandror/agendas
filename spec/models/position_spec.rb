require 'rails_helper'

RSpec.describe Position, type: :model do

  let(:position) { build(:position) }

  it "should be valid" do
    expect(position).to be_valid
  end

  it "should be invalid if no title" do
    position.title = nil

    expect(position).not_to be_valid
  end

  it "should be invalid if no area" do
    position.area = nil

    expect(position).not_to be_valid
  end

  it "should be invalid if no from" do
    position.from = nil
    position.to = nil

    expect(position).not_to be_valid
  end

  it "should be invalid if from date greater then to date" do
    position.from = Time.now
    position.to = Time.now - 1

    expect(position).not_to be_valid
  end

end