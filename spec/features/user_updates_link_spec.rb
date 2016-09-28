require "rails_helper"

RSpec.feature "update link status", js: true do
  scenario "user can click a button to update status" do
    user = create_and_authenticate_user
    link = create(:link, url: "https://www.google.com/", user: user)

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

  scenario "user can update link title" do
    user = create_and_authenticate_user
    link = create(:link, title: "Original Title", url: "https://www.google.com/", user: user)

    visit root_path

    expect(Link.find(link.id).title).to eq("Original Title")

    within "#link-#{link.id}" do
      expect(page).to have_content("Original Title")

      page.execute_script("$('#title-#{link.id}').html('UPDATED TITLE')")
      page.execute_script("$('#title-#{link.id}').blur()")

      expect(page).to_not have_content("Original Title")
      expect(page).to have_content("UPDATED TITLE")
    end

    expect(Link.find(link.id).title).to eq("UPDATED TITLE")
  end

  scenario "user can update link title" do
    user = create_and_authenticate_user
    link = create(:link, title: "Original Title", url: "https://www.google.com/", user: user)

    visit root_path

    expect(Link.find(link.id).title).to eq("Original Title")

    within "#link-#{link.id}" do
      expect(page).to have_content("https://www.google.com/")

      page.execute_script("$('#url-#{link.id}').html('https://www.stackoverflow.com')")
      page.execute_script("$('#url-#{link.id}').blur()")

      expect(page).to_not have_content("https://www.google.com/")
      expect(page).to have_content("https://www.stackoverflow.com")
    end

    expect(Link.find(link.id).url).to eq("https://www.stackoverflow.com")
  end
end
