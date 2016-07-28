require 'rails_helper'

describe 'user' do

  scenario 'user can be created' do
    expect{create(:user)}.to change{User.count}.by(1)
  end
end
