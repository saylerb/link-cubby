require "rails_helper"

RSpec.feature "update link status", js: true do
  scenario "user can click a button to update status" do
    user = create(:user)
    link = create(:link, url: "https://www.google.com/", user: user)

    allow_any_instance_of(ApplicationController).to receive(:current_user)
      .and_return(user)

    visit root_path

    within "#read-#{link.id}" do
      expect(page).to have_content("false")
    end

    within "#update-status-#{link.id}" do
      expect(page).to have_content("Mark as Read")

      click_on "Mark as Read"
    end

    within "#read-#{link.id}" do
      expect(page).to have_content("true")
    end

    within "#update-status-#{link.id}" do
      expect(page).to have_content("Mark as Unread")
    end
  end
end
