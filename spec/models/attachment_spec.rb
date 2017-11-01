require 'rails_helper'

RSpec.describe Attachment, type: :model do

  let(:attachment) { build(:attachment) }

  it "should be valid" do
    expect(attachment).to be_valid
  end

  it "should be invalid if no title" do
    attachment.title = ""

    expect(attachment).not_to be_valid
  end

end
