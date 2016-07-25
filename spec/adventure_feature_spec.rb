require "rails_helper"

feature "adventures" do
  scenario "User can see an adventure" do
    adventure = create(:adventure)
    visit "/"
    expect(page).to have_content "Makers"
  end
end
