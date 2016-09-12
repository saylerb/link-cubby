require 'rails_helper'

RSpec.describe "link create endpoint" do
  context "as authenticated user" do
    it "creates an link" do
      total_links = Link.count

      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user)
      .and_return(user)

      new_link_params = { title: "Stack Overflow",
                          url: "http://stackoverflow.com/",
                        }

      post "/api/v1/links", params: { link: new_link_params }

      expect(response.status).to eq(201)

      new_link_data = JSON.parse(response.body, symbolize_names: :true)

      expect(new_link_data[:title]).to eq(new_link_params[:title])
      expect(new_link_data[:url]).to eq(new_link_params[:url])

      expect(Link.count).to eq(total_links + 1)

      new_link = Link.last

      expect(new_link.title).to eq(new_link_params[:title])
      expect(new_link.url).to eq(new_link_params[:url])

    end
  end

  context "as unauthenticated user" do
    it "does not create a link" do
      total_links = Link.count

      new_link_params = { title: "Stack Overflow",
                          url: "http://stackoverflow.com/",
                        }

      post "/api/v1/links", params: { link: new_link_params }

      expect(response.status).to eq(422)

      expect(Link.count).to eq(total_links)
    end
  end
end
