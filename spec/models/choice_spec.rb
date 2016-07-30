require "rails_helper"

describe Choice, type: :model do

  it { should validate_presence_of(:option) }

  it { should validate_presence_of(:resulting_chapter_id) }

  it { should validate_presence_of(:chapter_id) }

  scenario "choice can be created" do
    adventure = create(:adventure)
    chapter = create(:chapter, adventure_id: adventure.id)
    resulting_chapter = create(:chapter, adventure_id: adventure.id)

    expect{create( :choice, chapter_id: chapter.id, resulting_chapter_id: resulting_chapter.id )}.to change{Choice.count}.by(1)
  end
end
