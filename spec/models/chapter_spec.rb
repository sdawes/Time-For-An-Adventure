require "rails_helper"

describe "Chapter" do

  scenario 'chapter can be created' do
    adventure = create(:adventure)
    expect{create(:chapter, adventure_id: adventure.id )}.to change{Chapter.count}.by(1)
  end

end
