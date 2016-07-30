require "rails_helper"

describe "adventures/show.html.erb" do
  scenario "it displays an adventures synopsis" do
      adventure = assign(:adventure, create(:adventure))
      chapter_1 = assign(:first_chapter, create(:chapter, description: "chapter 1", adventure_id: adventure.id))


      render

      expect(rendered).to have_content "Synopsis"
  end
end
