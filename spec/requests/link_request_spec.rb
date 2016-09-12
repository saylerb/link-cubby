RSpec.describe "link endpoint" do
  context "retrieve link information" do
    let!(:link1) { create(:link) }
    let!(:link2) { create(:link) }

    it "returns the information for all links" do
      get "/api/v1/links"

      data = JSON.parse(response.body, symbolize_names: :true )

      expect(response).to be_success

      link1_data, link2_data = data.first, data.last

      expect(link1_data.length).to eq(4)
      expect(link1_data[:id]).to eq(link1.id)
      expect(link1_data[:title]).to eq(link1.title)
      expect(link1_data[:url]).to eq(link1.url)
      expect(link1_data[:read]).to eq(false)

      expect(link2_data.length).to eq(4)
      expect(link2_data[:id]).to eq(link2.id)
      expect(link2_data[:title]).to eq(link2.title)
      expect(link2_data[:url]).to eq(link2.url)
      expect(link2_data[:read]).to eq(false)
    end
  end
end
