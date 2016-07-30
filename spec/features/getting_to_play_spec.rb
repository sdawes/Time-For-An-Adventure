require 'rails_helper'

feature "Getting to play the adventure" do

  scenario "Trying to play the game, but not logged in" do
    adventure = create(:adventure)
    chapter_1 = create(:chapter, description: "chapter 1", adventure_id: adventure.id)

    visit "/"
    click_link "Makers"
    click_link "Play"

    expect(current_path).to eq("/users/sign_in")
  end

  scenario "Redirecting to the play page after signing up" do
    adventure = create(:adventure)
    chapter_1 = create(:chapter, description: "chapter 1", adventure_id: adventure.id)

    visit "/"
    click_link "Makers"
    click_link "Play"
    click_link "Sign up"
    fill_in "User name", with: "User"
    fill_in "Email", with: "user@email.com"
    fill_in "Password", with: "123456"
    fill_in "Password confirmation", with: "123456"
    click_button "Sign up"

    expect(current_path).to eq("/adventures/#{adventure.id}/chapters/#{chapter_1.id}")
  end

  scenario "Redirecting to the play page after logging in" do
    user = FactoryGirl.create(:user)
    adventure = FactoryGirl.create(:adventure)
    chapter_1 = FactoryGirl.create(:chapter, description: "chapter 1", adventure_id: adventure.id)

    visit "/"
    click_link "Makers"
    click_link "Play"
    click_link "Log in"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"


    expect(current_path).to eq("/adventures/#{adventure.id}/chapters/#{chapter_1.id}")
  end



end
