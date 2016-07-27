require "rails_helper"

describe "adventures/show.html.erb" do
  scenario "it displays an adventures synopsis" do
      adventure = assign(:adventure, create(:adventure))

      render

      expect(rendered).to have_content 'Synopsis'
  end
end
