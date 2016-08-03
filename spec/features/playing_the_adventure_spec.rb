require "rails_helper"

feature "Playing the adventure" do

  xscenario "Viewing the first chapter with corresponding choices" do
    user = FactoryGirl.create(:user)
    adventure = FactoryGirl.create(:adventure)
    chapter_1 = FactoryGirl.create(:chapter, description: "chapter 1", adventure_id: adventure.id, parent_choice_id: null)
    choice_1 = FactoryGirl.create(:choice, option: "choice 1", chapter_id: chapter_1.id)
    choice_2 = FactoryGirl.create(:choice, option: "choice 2", chapter_id: chapter_1.id)
    login_as(user)

    visit "/"
    click_link "Makers"
    click_link "Play"

    expect(page).to have_content "chapter 1"
    expect(page).to have_content "choice 1"
    expect(page).to have_content "choice 2"
  end

  xscenario "Viewing the next chapter" do
    user = FactoryGirl.create(:user)
    adventure = FactoryGirl.create(:adventure)
    chapter_1 = FactoryGirl.create(:chapter, description: "chapter 1", adventure_id: adventure.id)
    chapter_2 = FactoryGirl.create(:chapter, description: "chapter 2", adventure_id: adventure.id)
    choice_1 = FactoryGirl.create(:choice, option: "choice 1", chapter_id: chapter_1.id)
    choice_2 = FactoryGirl.create(:choice, option: "choice 2", chapter_id: chapter_2.id)
    login_as(user)

    visit "/"
    click_link "Makers"
    click_link "Play"
    click_link "choice 1"

    expect(page).to have_content "chapter 2"
    expect(page).to have_content "choice 2"
   end
end
