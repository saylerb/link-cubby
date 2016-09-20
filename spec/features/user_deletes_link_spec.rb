require "rails_helper"

RSpec.feature "user deletes link", js: true do
  scenario "by clicking the delete button" do
    user = create(:user)
    link1 = create(:link, title: "Google", url: "https://www.google.com/", user: user)
    link2 = create(:link, title: "Stack Overflow",  url: "https://www.stackoverflow.com/", user: user)

    allow_any_instance_of(ApplicationController).to receive(:current_user)
      .and_return(user)

    visit root_path

    within "#table-body" do
      expect(page).to have_content(link1.title)
      expect(page).to have_content(link1.url)

      expect(page).to have_content(link2.title)
      expect(page).to have_content(link2.url)
    end

    within "#table-body" do

      within "#delete-#{link1.id}" do
        expect(page).to have_css('.delete')
        click_on 'Delete'
      end
      expect(page).to_not have_content(link1.title)
      expect(page).to_not have_content(link1.url)

      expect(page).to have_content(link2.title)
      expect(page).to have_content(link2.url)
    end
  end
end
