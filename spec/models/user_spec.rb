require 'rails_helper'

describe 'user' do

  it 'can be created' do
    expect{create(:user)}.to change{User.count}.by(1)
  end

  it 'cannot be created if username is taken' do
    user = create(:user)
    expect(User.new(user_name: user.user_name, email: 'new@email.com', password: '123123', password_confirmation: '123123')).to have(1).error_on(:user_name)
  end

  it 'cannot be created if email is taken' do
    user = create(:user)
    expect(User.new(user_name: 'new username', email: user.email, password: '123123', password_confirmation: '123123')).to have(1).error_on(:email)
  end

  it 'cannot be created if passwords do not match' do
    expect(User.new(user_name: 'new user', email: 'new@email.com', password: '111111', password_confirmation: '222222')).to have(1).error_on(:password_confirmation)
  end
end
