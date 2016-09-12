require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user, password: nil, password_confirmation: nil) }
  
  it "has a valid factory" do
    expect(user).to be_valid
  end

  context "responds to the correct attributes" do
    it { expect(user).to respond_to(:email) }
    it { expect(user).to respond_to(:password) }
  end

  context "validations" do
    it { expect(user_without_password).to validate_presence_of(:email) }
    it { expect(user_without_password).to validate_uniqueness_of(:email) }
    it { expect(user_without_password).to validate_presence_of(:password) }
    it { expect(user_without_password).to validate_confirmation_of(:password) }
  end
end
