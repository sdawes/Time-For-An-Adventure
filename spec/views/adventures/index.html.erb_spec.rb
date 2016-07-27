require "rails_helper"

describe "adventures/index.html.erb" do
  scenario "it displays an adventures title" do
      adventures = assign(:adventures, [create(:adventure)])

      render

      expect(rendered).to have_link "Makers", href: "/adventures/#{adventures.first.id}"
  end
end
