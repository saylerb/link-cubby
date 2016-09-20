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

  describe "validates URLs" do

    it "should accept a valid URL" do
      link1 = build(:link, url: 'http://www.google.com')
      link2 = build(:link, url: 'https://www.reddit.com')
      link3 = build(:link, url: 'https://www.stackoverflow.com')

      [link1, link2, link3].each { |link| expect(link).to be_valid }
    end

    it "should reject an invalid URL-like string" do
      link1 = build(:link, url: 'www.google.com')
      link2 = build(:link, url: 'www.reddit.com')
      link3 = build(:link, url: 'www.stackoverflow.com')

      [link1, link2, link3].each { |link| expect(link).to be_invalid }
    end

    it "should reject non-URL strings" do
      link1 = build(:link, url: 'NON-URL-STRING')
      link2 = build(:link, url: 'nonurlstring')
      link3 = build(:link, url: 'http://')

      [link1, link2, link3].each { |link| expect(link).to be_invalid }
    end

    it "should reject a blank URL" do
      link = build(:link, url: '')
      expect(link).to be_invalid
    end
  end

  describe "sorts URLs using params" do
    it "should sort URLS desc by title" do
      user = create(:user)
      link1 = create(:link, title: "AAA", url: 'http://www.google.com', user: user)
      link2 = create(:link, title: "ZZZ", url: 'https://www.reddit.com', user: user)
      link3 = create(:link, title: "MMM", url: 'https://www.stackoverflow.com', user: user)

      expect(Link.sort_by_params(user, 'title', 'desc').first).to eq(link2)
      expect(Link.sort_by_params(user, 'title', 'desc').last).to eq(link1)
    end

    it "should sort URLS asc by title" do
      user = create(:user)
      link1 = create(:link, title: "AAA", url: 'http://www.google.com', user: user)
      link2 = create(:link, title: "ZZZ", url: 'https://www.reddit.com', user: user)
      link3 = create(:link, title: "MMM", url: 'https://www.stackoverflow.com', user: user)

      expect(Link.sort_by_params(user, 'title', 'asc').first).to eq(link1)
      expect(Link.sort_by_params(user, 'title', 'asc').last).to eq(link2)
    end

    it "should sort URLS desc by url" do
      user = create(:user)
      link1 = create(:link, title: "AAA", url: 'http://www.google.com', user: user)
      link2 = create(:link, title: "ZZZ", url: 'https://www.reddit.com', user: user)
      link3 = create(:link, title: "MMM", url: 'https://www.stackoverflow.com', user: user)

      expect(Link.sort_by_params(user, 'url', 'desc').first).to eq(link3)
      expect(Link.sort_by_params(user, 'url', 'desc').last).to eq(link1)
    end

    it "should sort URLS asc by url" do
      user = create(:user)
      link1 = create(:link, title: "AAA", url: 'http://www.google.com', user: user)
      link2 = create(:link, title: "ZZZ", url: 'https://www.reddit.com', user: user)
      link3 = create(:link, title: "MMM", url: 'https://www.stackoverflow.com', user: user)

      expect(Link.sort_by_params(user, 'url', 'asc').first).to eq(link1)
      expect(Link.sort_by_params(user, 'url', 'asc').last).to eq(link3)
    end
  end
end
