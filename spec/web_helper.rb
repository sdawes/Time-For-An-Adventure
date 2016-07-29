def sign_in_with(user)
  visit '/'
  within('.nav_links') do
    click_button 'Log in'
  end
  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password
  within('.actions') do
    click_button 'Log in'
  end
end

def sign_up(username, email, password, password_confirmation)
  visit "/"
  within(".nav_links") do
    click_button "Sign up"
  end
  fill_in "User name", with: username
  fill_in "Email", with: email
  fill_in "Password", with: password
  fill_in "Password confirmation", with: password_confirmation
  within(".actions") do
    click_button "Sign up"
  end
end
