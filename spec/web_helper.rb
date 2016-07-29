def sign_in_with(user)
  visit '/'

  click_link 'Log in'

  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password

  click_button 'Log in'

end
