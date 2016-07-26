require "rails_helper"

feature "adventures" do
  scenario "User can see an adventure" do
    visit "/"
    expect(page).to have_content "Makers"
  end
end
