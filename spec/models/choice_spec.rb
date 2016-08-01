require "rails_helper"

describe Choice, type: :model do

  xit { should validate_presence_of(:option) }

  xit { should validate_presence_of(:resulting_chapter_id) }

  xit { should validate_presence_of(:chapter_id) }

  xscenario "choice can be created" do
    adventure = create(:adventure)
    chapter = create(:chapter, adventure_id: adventure.id)
    resulting_chapter = create(:chapter, adventure_id: adventure.id)

    expect{create( :choice, chapter_id: chapter.id, resulting_chapter_id: resulting_chapter.id )}.to change{Choice.count}.by(1)
  end
end
