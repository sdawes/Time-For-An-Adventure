require "rails_helper"

describe User, type: :model do

  it { should validate_presence_of(:user_name) }

  it { should validate_uniqueness_of(:user_name) }

  it { should validate_length_of(:user_name).is_at_least(4) }

  it { should validate_length_of(:user_name).is_at_most(16) }

  it { should validate_presence_of(:email) }

  it { should validate_length_of(:password).is_at_least(6) }


end

describe "user" do

  it "can be created" do
    expect{create(:user)}.to change{User.count}.by(1)
  end

  it "cannot be created if email is taken" do
    user = create(:user)

    expect(User.new(user_name: "new username", email: user.email, password: "123123", password_confirmation: "123123")).to have(1).error_on(:email)
  end

  it "cannot be created if email is taken(case insensitive)" do
    user = create(:user)

    expect(User.new(user_name: "new username", email: "FANCYFRANK@gmail.com", password: "123123", password_confirmation: "123123")).to have(1).error_on(:email)
  end

  it "cannot be created if passwords do not match" do
    expect(User.new(user_name: "new user", email: "new@email.com", password: "111111", password_confirmation: "222222")).to have(1).error_on(:password_confirmation)
  end
end
