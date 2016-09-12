require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user1) { build(:user) }
  let(:user2) { build(:user, password: nil, password_confirmation: nil) }
  
  it "has a valid factory" do
    expect(user1).to be_valid
  end

  context "responds to the correct attributes" do
    it { expect(user1).to respond_to(:email) }
    it { expect(user1).to respond_to(:password) }
  end

  context "validations" do
    it { expect(user2).to validate_presence_of(:email) }
    it { expect(user2).to validate_uniqueness_of(:email) }
    it { expect(user2).to validate_presence_of(:password) }
    it { expect(user2).to validate_confirmation_of(:password) }
  end

  it "has many links" do
    expect(user1).to have_many(:links)
  end
end
