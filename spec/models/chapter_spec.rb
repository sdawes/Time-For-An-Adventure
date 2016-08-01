require "rails_helper"


describe Chapter, type: :model do

  xit { should validate_presence_of(:description) }

  xit { should validate_presence_of(:adventure_id) }

  scenario "chapter can be created" do
    adventure = create(:adventure)
    expect{create( :chapter, adventure_id: adventure.id )}.to change{Chapter.count}.by(1)
  end
end
