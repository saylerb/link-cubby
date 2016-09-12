require 'rails_helper'

RSpec.feature "user log out" do

  let(:user) { create(:user) }

  scenario "from the root path" do
    user = create(:user)
    visit login_path

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"

    within("nav") do
      expect(page).to have_content("#{user.email}")
      expect(page).to_not have_content("Log In")
      expect(page).to have_content("Log Out")
    end

    click_link "Log Out"

    within(".alert") do
      expect(page).to have_content("Successfully Logged Out")
    end

    expect(current_path).to eq("/login")
  end
end
