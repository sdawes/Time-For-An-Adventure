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
