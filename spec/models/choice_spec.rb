require 'rails_helper'

describe "Choice" do
  scenario "choice can be created" do
    adventure = create(:adventure)
    chapter = create(:chapter, adventure_id: adventure.id)
    expect{create(:choice, chapter_id: chapter.id )}.to change{Choice.count}.by(1)
  end
end
