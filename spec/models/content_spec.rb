require "rails_helper"

describe Content do
  subject { content }
  it { should be_valid }

  let!(:content){FactoryGirl.create :content}

  describe "validates sentence" do
    it { should validate_presence_of(:sentence) }
  end
end