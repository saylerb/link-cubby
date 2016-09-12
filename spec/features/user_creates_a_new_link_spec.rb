require "rails_helper"

RSpec.feature "create new link", js: true do
  context "unauthenticated user" do
    scenario "cannot see the new link form" do
      visit root_path

      expect(page).to_not have_css("#new-link")
    end
  end

  context "authenticated user" do
    scenario "should see two text boxes to input a new idea" do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user)
        .and_return(user)

      visit root_path

      expect(page).to have_css("#new-link")

      within "#new-link" do
        expect(page).to have_css(".form-group")
        expect(page).to have_css("#title-field")
        expect(page).to have_css("#url-field")
      end

      within("#new-link") do
        fill_in "Title:", with: "Stack Overflow"
        fill_in "URL:", with: "http://stackoverflow.com/"
        click_on "Save"
      end

      within "#links-table" do
        expect(page).to have_content("Stack Overflow")
        expect(page).to have_content("http://stackoverflow.com/")
      end
    end
  end
end
