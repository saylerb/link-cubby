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

      within "#table-body" do
        user_links.each do |link|
          within "#title-#{link.id}" do 
           expect(page).to have_content(link.title)
          end

          within "#url-#{link.id}" do 
            expect(page).to have_content(link.url)
          end

          within "#read-#{link.id}" do 
            expect(page).to have_content("false")
          end
        end

        other_links.each do |link|
          expect(page).to_not have_css("#title-#{link.id}")
          expect(page).to_not have_css("#url-#{link.id}")
          expect(page).to_not have_css("#read-#{link.id}")
        end
      end
    end
  end

  context "as unauthenticated user" do
    scenario "and cannot see links" do
      visit root_path

      expect(current_path).to eq(login_path)
    end
  end
end
