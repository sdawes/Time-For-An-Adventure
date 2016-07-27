require "rails_helper"

describe "chapters/index.html.erb" do
  scenario "it displays an chapters description" do
      adventure = create(:adventure)
      chapters = assign(:chapters, [create(:chapter, adventure_id: adventure.id)])

      render

      expect(rendered).to have_content 'Chapter 1'
  end
end
