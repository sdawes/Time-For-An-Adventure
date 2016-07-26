require "rails_helper"

feature "adventures" do

  scenario "User can see an adventure" do
    adventure = create(:adventure)
    visit "/"
    expect(page).to have_content "Makers"
  end

  scenario "User can select an adventure" do
    adventure = create(:adventure)

    visit "/"
    click_link "Makers"
    expect(current_path).to eq "/adventures/#{adventure.id}"
    expect(page).to have_content "Synopsis"
  end
end
