require "rails_helper"

describe Tag do
  subject { tag }
  it { should be_valid }

  let!(:tag){FactoryGirl.create :tag}

  describe "validates content" do
    it { should validate_presence_of(:content) }
  end
end