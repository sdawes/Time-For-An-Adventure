require "rails_helper"

feature "adventures" do

  scenario "User can see an adventure" do
    adventure = create(:adventure)
    visit "/"
    expect(page).to have_content "Makers"
  end

  scenario "User can select an adventure" do
    adventure = create(:adventure)
    chapter_1 = create(:chapter, description: "chapter 1", adventure_id: adventure.id)


    visit "/"
    click_link "Makers"
    expect(current_path).to eq "/adventures/#{adventure.id}"
    expect(page).to have_content "Synopsis"
  end

  scenario "User can see the first chapter logged in" do
    user = FactoryGirl.create(:user)
    adventure = create(:adventure)
    chapter = create(:chapter, adventure_id: adventure.id)
    login_as(user)

    visit "/"
    click_link "Makers"
    click_link "Play"

    expect(page).to have_content("Chapter 1")
    expect(current_path).to eq "/adventures/#{adventure.id}/chapters/#{chapter.id}"
  end

  scenario "User can't see the first chapter unless logged in" do
    adventure = create(:adventure)
    chapter_1 = create(:chapter, description: "chapter 1", adventure_id: adventure.id)

    visit "/"
    click_link "Makers"
    click_link "Play"
    expect(page).not_to have_content("Chapter 1")
    expect(current_path).to eq "/users/sign_in"
    expect(page).to have_content "Log in"
  end
end
