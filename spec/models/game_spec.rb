require "rails_helper"

describe Game, type: :model do

  it { should validate_presence_of(:user_id) }

  it { should validate_presence_of(:adventure_id) }

  it { should validate_presence_of(:chapters) }

  scenario "game can be created" do
    user = create(:user)
    adventure = create(:adventure)
    expect{create( :game, chapters: "1", user_id: user.id, adventure_id: adventure.id )}.to change{Game.count}.by(1)
  end

end
