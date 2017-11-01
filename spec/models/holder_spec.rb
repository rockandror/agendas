require 'rails_helper'

RSpec.describe Holder, type: :model do

  let(:holder) { build(:holder) }

  it "should be valid" do
    expect(holder).to be_valid
  end

  it "should not be valid without first_name" do
    holder.first_name = nil

    expect(holder).not_to be_valid
  end

  it "should not be valid without last_name" do
    holder.last_name = nil

    expect(holder).not_to be_valid
  end

  it "should not be valid without any position" do
    holder.positions = []

    expect(holder).not_to be_valid
  end

  context "#full_name" do
    it 'should get full name from first and last name' do
      expect(holder.full_name).to eq "#{holder.first_name} #{holder.last_name}"
    end
  end

  context "#full_name_comma" do
    it 'should get full name comma from first and last name' do
      expect(holder.full_name_comma).to eq "#{holder.last_name}, #{holder.first_name}"
    end
  end

end