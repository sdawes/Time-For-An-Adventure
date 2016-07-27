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

  scenario "User can see the first chapter of the adventure" do
    adventure = create(:adventure)
    chapter = create(:chapter, adventure_id: adventure.id)
    user = create(:user)

    sign_in_with(user)
    click_link "Makers"
    click_button "Play"
    expect(current_path).to eq "/adventures/#{adventure.id}/chapters"
    expect(page).to have_content("Chapter 1")
  end

  scenario "User can't see the first chapter unless logged in" do
    adventure = create(:adventure)
    chapter = create(:chapter, adventure_id: adventure.id)

    visit "/"
    click_link "Makers"
    click_button "Play"
    expect(page).not_to have_content("Chapter 1")
    expect(current_path).to eq "/users/sign_up"
    expect(page).to have_content "Log in"
  end
end
