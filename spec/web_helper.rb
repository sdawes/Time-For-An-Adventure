def log_in_with(user)
  visit '/'

  click_link 'Log in'

  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password

  click_button 'Log in'

end

def sign_up(username, email, password, password_confirmation)
  visit "/"
  click_link "Sign up"
  fill_in "User name", with: username
  fill_in "Email", with: email
  fill_in "Password", with: password
  fill_in "Password confirmation", with: password_confirmation
  click_button "Sign up"
end
