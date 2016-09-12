require "rails_helper"

RSpec.feature "visitor signup" do
  scenario "they are redirected to a form to Sign-Up or Login" do
    user = build(:user)

    visit root_path

    click_on "Sign Up"

    expect(current_path).to eq(new_user_path)

    within(".signup-form") do 
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      fill_in "Password Confirmation", with: user.password
      click_button "Sign Up"
    end

    within ".alert" do
      expect(page).to have_content("Successfully Logged In!")
    end

    expect(current_path).to eq(root_path)

    within(".navbar") do
      expect(page).to have_content("Logged in as #{user.email}")
      expect(page).to have_content("Log Out")
      expect(page).not_to have_content("Log In")
    end
  end
end
