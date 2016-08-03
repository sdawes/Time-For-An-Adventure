require "rails_helper"

feature "Playing the adventure" do

  scenario "Viewing the first chapter with corresponding choices" do
    user = FactoryGirl.create(:user)
    adventure = FactoryGirl.create(:adventure)
    chapter_1 = FactoryGirl.create(:chapter, description: "chapter 1", adventure_id: adventure.id)
    choice_1 = FactoryGirl.create(:choice, option: "choice 1", chapter_id: chapter_1.id)
    chapter_2 = FactoryGirl.create(:chapter, description: "chapter 2", adventure_id: adventure.id, parent_choice_id: choice_1.id)
    login_as(user)

    visit "/"
    click_link "Makers"
    click_link "Play"

    expect(page).to have_content "chapter 1"
    expect(page).to have_content "choice 1"
  end

  scenario "Viewing the next chapter" do
    user = FactoryGirl.create(:user)
    adventure = FactoryGirl.create(:adventure)
    chapter_1 = FactoryGirl.create(:chapter, description: "chapter 1", adventure_id: adventure.id)
    choice_1 = FactoryGirl.create(:choice, option: "choice 1", chapter_id: chapter_1.id)
    chapter_2 = FactoryGirl.create(:chapter, description: "chapter 2", adventure_id: adventure.id, parent_choice_id: choice_1.id)
    choice_2 = FactoryGirl.create(:choice, option: "choice 2", chapter_id: chapter_2.id)
    chapter_3 = FactoryGirl.create(:chapter, description: "chapter 3", adventure_id: adventure.id, parent_choice_id: choice_2.id)
    login_as(user)

    visit "/"
    click_link "Makers"
    click_link "Play"
    click_link "choice 1"

    expect(page).to have_content "chapter 2"
    expect(page).to have_content "choice 2"
  end

  scenario "Saves progress to the game" do
    user = FactoryGirl.create(:user)
    adventure = FactoryGirl.create(:adventure)
    chapter_1 = FactoryGirl.create(:chapter, description: "chapter 1", adventure_id: adventure.id)
    choice_1 = FactoryGirl.create(:choice, option: "choice 1", chapter_id: chapter_1.id)
    chapter_2 = FactoryGirl.create(:chapter, description: "chapter 2", adventure_id: adventure.id, parent_choice_id: choice_1.id)
    choice_2 = FactoryGirl.create(:choice, option: "choice 2", chapter_id: chapter_2.id)
    chapter_3 = FactoryGirl.create(:chapter, description: "chapter 3", adventure_id: adventure.id, parent_choice_id: choice_2.id)
    login_as(user)

    visit "/"
    click_link "Makers"
    click_link "Play"
    click_link "choice 1"
    click_link "Log out"
    click_link "Makers"
    click_link "Play"
    log_in_with(user)
    game = Game.where(adventure_id: adventure.id, user_id: user.id).first

    expect(game).to be_truthy
    expect(game.choices.split(',').last).to eq("#{choice_1.id}")
    expect(game.chapters.split(',').last).to eq("#{chapter_2.id}")
    expect(page).to have_content "chapter 2"
    expect(page).to have_content "choice 2"
  end

  scenario "Saves progress to the game" do
    user = FactoryGirl.create(:user)
    adventure = FactoryGirl.create(:adventure)
    chapter_1 = FactoryGirl.create(:chapter, description: "chapter 1", adventure_id: adventure.id)
    choice_1 = FactoryGirl.create(:choice, option: "choice 1", chapter_id: chapter_1.id)
    chapter_2 = FactoryGirl.create(:chapter, description: "chapter 2", adventure_id: adventure.id, parent_choice_id: choice_1.id)
    choice_2 = FactoryGirl.create(:choice, option: "choice 2", chapter_id: chapter_2.id)
    chapter_3 = FactoryGirl.create(:chapter, description: "chapter 3", adventure_id: adventure.id, parent_choice_id: choice_2.id)
    login_as(user)

    visit "/"
    click_link "Makers"
    click_link "Play"
    click_link "choice 1"
    click_link "Start Again"
    game = Game.where(adventure_id: adventure.id, user_id: user.id).first

    expect(game).to be_truthy
    expect(game.choices.split(',').last).to be(nil)
    expect(game.chapters.split(',').last).to eq("#{chapter_1.id}")
    expect(page).to have_content "chapter 1"
    expect(page).to have_content "choice 1"
  end
end
