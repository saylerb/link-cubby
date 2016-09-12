require "rails_helper"

RSpec.feature "user views links", js: true do
  let!(:user) { create(:user) }
  let!(:user_links) { create_list(:link, 2, user: user) }
  let!(:other_links) { create_list(:link, 2) }


  context "as authenticated user" do
    scenario "and sees a table with the links" do

      allow_any_instance_of(ApplicationController).to receive(:current_user)
        .and_return(user)

      visit root_path

      within "table" do
        user_links.each do |link|
          expect(page).to have_content(link.title)
          expect(page).to have_content(link.body)
          expect(page).to have_content("false")
        end

        other_links.each do |link|
          expect(page).to have_content(link.title)
          expect(page).to have_content(link.body)
          expect(page).to have_content("false")
        end
      end
    end
  end

  context "as unauthenticated user" do
    scenario "and cannot see links" do
      visit root_path

      all_links = user_links + other_links

      within "table" do
        all_links.each do |link|
          expect(page).to have_content(link.title)
          expect(page).to have_content(link.body)
          expect(page).to have_content("false")
        end
      end
    end
  end
end
