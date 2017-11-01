require 'rails_helper'

RSpec.describe Area, type: :model do

  let(:area) { build(:area) }

  it "should be valid" do
    expect(area).to be_valid
  end

  it "should not be valid without title" do
    area.title = ""

    expect(area).not_to be_valid
  end

  it "should be active when created" do
    area.save

    expect(area.active).to be
  end

  it "should be active if parent is set to active" do
    parent_area = FactoryGirl.create(:area, active: true)

    area.parent = parent_area
    area.save

    expect(area.active).to be
  end

  it "should be inactive if parent is set to inactive" do
    parent_area = FactoryGirl.create(:area, active: false)

    area.parent = parent_area
    area.save

    expect(area.active).not_to be true
  end

end
