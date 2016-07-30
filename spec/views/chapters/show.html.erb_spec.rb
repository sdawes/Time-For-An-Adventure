require "rails_helper"

describe "chapters/show.html.erb" do
  scenario "it does not show first chapter when user logged out" do
    adventure = create(:adventure)
    chapter = create(:chapter, adventure_id: adventure.id)
    resulting_chapter = create(:chapter, adventure_id: adventure.id)
    choice = create(:choice, chapter_id: chapter.id, resulting_chapter_id: resulting_chapter.id )
    assign(:choices, [choice])
    assign(:chapter, chapter)

    render

    expect(rendered).to have_content("Chapter 1")
  end
end
