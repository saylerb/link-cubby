require 'rails_helper'

RSpec.describe "link endpoint" do
  let!(:user) { create(:user) }
  let!(:link1) { create(:link, user: user) }
  let!(:link2) { create(:link, user: user) }

  context "as authenticated user" do
    it "returns the information for the user's links" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      get "/api/v1/links"

      data = JSON.parse(response.body, symbolize_names: :true )

      expect(response).to be_success

      link1_data, link2_data = data.last, data.first

      expect(link1_data.length).to eq(4)
      expect(link1_data[:title]).to eq(link1.title)
      expect(link1_data[:url]).to eq(link1.url)
      expect(link1_data[:read]).to eq(false)

      expect(link2_data.length).to eq(4)
      expect(link2_data[:title]).to eq(link2.title)
      expect(link2_data[:url]).to eq(link2.url)
      expect(link2_data[:read]).to eq(false)
    end
  end

  context "as unauthenticated user" do
    it "should not return links" do
      get "/api/v1/links"

      expect(response).to_not be_success
    end
  end

end
