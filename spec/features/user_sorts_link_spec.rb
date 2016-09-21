require "rails_helper"

RSpec.feature "user can sort links", js: true do
  context "by title" do
    scenario "descending on the first click" do
      user = create_and_authenticate_user
      link1 = create(:link, title: "AAA", url: 'http://www.google.com', user: user)
      link2 = create(:link, title: "MMM", url: 'https://www.stackoverflow.com', user: user)
      link3 = create(:link, title: "ZZZ", url: 'https://www.reddit.com', user: user)

      visit root_path

      page.execute_script("$('#title-header').children().first().click()")

      within "tbody tr:nth-child(1)" do
        expect(page).to have_content(link3.title)
      end

      within "tbody tr:nth-child(2)" do
        expect(page).to have_content(link2.title)
      end

      within "tbody tr:nth-child(3)" do
        expect(page).to have_content(link1.title)
      end
    end

    scenario "ascending on the second click" do
      user = create_and_authenticate_user
      link1 = create(:link, title: "AAA", url: 'http://www.google.com', user: user)
      link2 = create(:link, title: "MMM", url: 'https://www.stackoverflow.com', user: user)
      link3 = create(:link, title: "ZZZ", url: 'https://www.reddit.com', user: user)

      visit root_path

      page.execute_script("$('#title-header').children().first().click()")
      page.execute_script("$('#title-header').children().first().click()")

      within "tbody tr:nth-child(1)" do
        expect(page).to have_content(link1.title)
      end

      within "tbody tr:nth-child(2)" do
        expect(page).to have_content(link2.title)
      end

      within "tbody tr:nth-child(3)" do
        expect(page).to have_content(link3.title)
      end
    end
  end
end
