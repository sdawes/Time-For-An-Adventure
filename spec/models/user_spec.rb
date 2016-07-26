require 'rails_helper'

describe 'user' do
  
  scenario 'user can be created' do
    expect{create(:user)}.to change{User.count}.from(0).to(1)
  end
end
