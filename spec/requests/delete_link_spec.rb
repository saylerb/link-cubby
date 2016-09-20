require 'rails_helper'

RSpec.describe "link endpoint" do
  it "deletes an link" do
    link1 = create(:link, url: 'http://www.google.com')
    link2 = create(:link, url: 'http://www.stackoverflow.com')

    expect(Link.where(id: link1.id, title: link1.title)).to exist
    expect(Link.where(id: link2.id, title: link2.title)).to exist
    
    delete "/api/v1/links/#{link1.id}"

    expect(response.status).to eq(204)
    expect(Link.where(id: link1.id, title: link1.title)).to_not exist
    expect(Link.where(id: link2.id, title: link2.title)).to exist
  end
end
