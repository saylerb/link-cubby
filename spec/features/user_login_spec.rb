require 'rails_helper'

RSpec.feature "registered user logs in" do
  let(:user) { create(:user) }

  context "with valid credentials" do
    scenario "from the root path" do
      visit root_path

      click_link "Log In"

      expect(current_path).to eq(login_path)

      fill_in "Email", with: user.email
      fill_in "Password", with: "password"

      click_button "Sign In"

      expect(current_path).to eq(root_path)

      within ".alert" do
        expect(page).to have_content("Successfully Logged In!")
      end

      within(".navbar") do
        expect(page).to have_content("#{user.email}")
        expect(page).to_not have_content("Login")
        expect(page).to have_content("Log Out")
      end
    end
  end
end
