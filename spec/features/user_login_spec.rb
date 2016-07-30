require "rails_helper"
# A test is pending but works! - to run use selnium (gemfile) and firefox (version 41.0.1)

feature "User authentication" do
  xscenario "html validation requires a user name to log in(selenium test)", js: true do
    visit "/users/sign_in"
    fill_in "Password", with: "password"
    click_link "Log in"

    expect(current_path).to eq "/users/sign_in"
  end

  scenario "A user without an account can not log in " do
    user = build(:user)

    log_in_with(user)

    expect(page).to have_content("Invalid Email or password.")
  end

  scenario "A user with an account can log in" do
    user = create(:user)

    log_in_with(user)

    expect(page).to have_content("Signed in successfully.")
    expect(page).to_not have_content("Sign up")
    expect(page).to have_link("Log out")
  end

  scenario "A user with an account can log out" do
    user = create(:user)

    log_in_with(user)

    click_link "Log out"

    expect(page).to have_content("Signed out successfully")
  end
end

feature "User cannot sign up" do
  scenario "username already exists" do
    user = create(:user)
    sign_up(user.user_name, "new@email.com", user.password, user.password_confirmation)

    expect(page).to have_content("User name has already been taken")
  end

  scenario "email already exists" do
    user = create(:user)
    sign_up("new user", user.email, user.password, user.password_confirmation)

    expect(page).to have_content("Email has already been taken")
  end

  scenario "passwords do not match" do
    sign_up("username", "email@email.com", "password", "different password")
    
    expect(page).to have_content("Password confirmation doesn't match Password")
  end
end
