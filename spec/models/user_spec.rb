require 'rails_helper'

describe User, type: :model do

  it { should validate_presence_of(:user_name) }
  it { should validate_presence_of(:email) }
end

describe 'user' do

  scenario 'user can be created' do
    expect{create(:user)}.to change{User.count}.by(1)
  end
end
