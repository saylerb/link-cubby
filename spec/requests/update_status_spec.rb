require 'rails_helper'

RSpec.describe "link update endpoint" do
  let!(:link1) { create(:link, url: "https://www.google.com/") }
  let!(:link2) { create(:link, url: "https://www.google.com/") }

  it "updates a link status to true" do
    expect(Link.where(id: link1.id, title: link1.title)).to exist
    expect(link1.read).to eq(false)

    edit_link_params = { read: true }

    put "/api/v1/links/#{link1.id}", params: { link: edit_link_params}

    expect(response.status).to eq(200)

    edit_link_data = JSON.parse(response.body, symbolize_names: :true)


    expect(edit_link_data[:title]).to eq(link1.title)
    expect(edit_link_data[:url]).to eq(link1.url)
    expect(edit_link_data[:read]).to eq(true)

    updated_link = Link.find(link1.id)

    expect(updated_link.title).to eq(link1.title)
    expect(updated_link.url).to eq(link1.url)
    expect(updated_link.read).to eq(true)
  end

  it "updates a link" do
    expect(Link.where(id: link1.id, title: link1.title)).to exist

    edit_link_params = {title: "Turing",
                        url: "http://turing.io/",
                        read: true
                       }

    put "/api/v1/links/#{link1.id}", params: { link: edit_link_params}

    expect(response.status).to eq(200)

    edit_link = Link.find(link1.id)

    expect(edit_link.title).to eq(edit_link_params[:title])
    expect(edit_link.url).to eq(edit_link_params[:url])
    expect(edit_link.read).to eq(edit_link_params[:read])

    edit_link_data = JSON.parse(response.body, symbolize_names: :true)

    expect(edit_link_data[:title]).to eq(edit_link_params[:title])
    expect(edit_link_data[:url]).to eq(edit_link_params[:url])
    expect(edit_link_data[:read]).to eq(edit_link_params[:read])
  end
end
