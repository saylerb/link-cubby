require 'rails_helper'

RSpec.describe Link, type: :model do

  let(:link) { build(:link) }

  it "has a valid factory" do
    expect(link).to be_valid
  end

  describe "responds to the correct attributes" do
    it { expect(link).to respond_to(:title) }
    it { expect(link).to respond_to(:url) }
    it { expect(link).to respond_to(:read) }
    it { expect(link).to respond_to(:created_at) }
    it { expect(link).to respond_to(:updated_at) }
  end

  describe "belongs to a user" do
    it { expect(link).to belong_to(:user) }
  end

  describe "validates for correct attributes" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:url) }
  end
end
