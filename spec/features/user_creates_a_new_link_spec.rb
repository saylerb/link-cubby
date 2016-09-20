require "rails_helper"

RSpec.feature "create new link", js: true do
  context "unauthenticated user" do
    scenario "cannot see the new link form" do
      visit root_path

      expect(page).to_not have_css("#new-link")
    end
  end

  context "authenticated user" do
    scenario "can see two text boxes to input a new idea" do
      authenticate_user

      visit root_path

      expect(page).to have_css("#new-link")

      within "#new-link" do
        expect(page).to have_css(".form-group")
        expect(page).to have_css("#title-field")
        expect(page).to have_css("#url-field")
      end
    end

    scenario "can enter a link with valid attributes" do
      authenticate_user

      visit root_path

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

    scenario "should not be able to add a link without a title" do
      authenticate_user

      visit root_path

      within("#new-link") do
        fill_in "URL:", with: "http://stackoverflow.com/"
        click_on "Save"
      end

      within "#links-table" do
        expect(page).to have_content("Title can't be blank")
        expect(page).to_not have_content("http://stackoverflow.com/")
      end
    end

    scenario "should not be able to add a link without a URL" do
      authenticate_user

      visit root_path

      within("#new-link") do
        fill_in "Title:", with: "Stack Overflow"
        click_on "Save"
      end

      within "#links-table" do
        expect(page).to have_content("Url can't be blank")
        expect(page).to_not have_content("Stack Overflow")
      end
    end
  end
end

private

def authenticate_user
  user = create(:user)
  allow_any_instance_of(ApplicationController).to receive(:current_user)
    .and_return(user)
end
