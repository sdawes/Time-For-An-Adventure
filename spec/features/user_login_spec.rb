require 'rails_helper'
# A test is pending but works! - to run use selnium (gemfile) and firefox (version 41.0.1)

feature "User authentication" do
  xscenario "html validation requires a user name to log in", js: true do
    visit "/users/sign_in"
    fill_in "Password", with: "password"
    click_link "Log in"

    expect(current_path).to eq "/users/sign_in"
  end

  scenario "A user without an account can not log in " do
    @user = build(:user)

    sign_in_with @user

    expect(page).to have_content("Invalid Email or password.")
  end

  scenario "A user with an account can log in" do
    @user = create(:user)

    sign_in_with @user

    expect(page).to have_content("Signed in successfully.")
    expect(page).to_not have_content("Sign up")
    expect(page).to have_content("Log out")
  end

  scenario "A user with an account can log out" do
    @user = create(:user)

    sign_in_with @user
    click_link "Log out"

    expect(page).to have_content("Signed out successfully")
  end
end
