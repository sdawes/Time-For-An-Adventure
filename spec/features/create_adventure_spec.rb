require 'rails_helper'

feature "Creating Adventure" do
  scenario "user can see a create link" do
    FactoryGirl.create(:choice, option: "Start", chapter_id: nil)
    user = create(:user)
    log_in_with(user)

    expect(page).to have_link "Create"
  end

  scenario "user can create an adventure" do
        FactoryGirl.create(:choice, option: "Start", chapter_id: nil)
    user = create(:user)
    log_in_with(user)

    click_link "Create"

    expect(page).to have_content "Create a new Adventure"
  end

  scenario "user can access an adventure design page" do
    FactoryGirl.create(:choice, option: "Start", chapter_id: nil)
    user = create(:user)
    log_in_with(user)

    click_link "Create"
    fill_in "Title", with: "Romeo and Juliet"
    fill_in "Synopsis", with: "The only title I could think of"
    attach_file 'Image', "/Users/jojograndjojo/Projects2/TFAA/lib/assets/owl jolson.jpeg"
    click_button "submit"

    expect(page).to have_content "Add a chapter"

  end

  scenario "user can create a chapter" do
    FactoryGirl.create(:choice, option: "Start", chapter_id: nil)
    user = create(:user)
    log_in_with(user)

    click_link "Create"
    fill_in "Title", with: "Romeo and Juliet"
    fill_in "Synopsis", with: "The only title I could think of"
    attach_file 'Image', "/Users/jojograndjojo/Projects2/TFAA/lib/assets/owl jolson.jpeg"
    click_button "submit"


    expect(page).to have_content "Description"
  end

  scenario "user can create the first chapter" do
    FactoryGirl.create(:choice, option: "Start", chapter_id: nil)
    user = create(:user)
    log_in_with(user)

    click_link "Create"
    fill_in "Title", with: "Romeo and Juliet"
    fill_in "Synopsis", with: "The only title I could think of"
    attach_file 'Image', "/Users/jojograndjojo/Projects2/TFAA/lib/assets/owl jolson.jpeg"
    click_button "submit"


    expect(page).to have_content "Add a chapter"
  end

  scenario "user can view the first chapter on the main page" do
    FactoryGirl.create(:choice, option: "Start", chapter_id: nil)
    user = create(:user)
    log_in_with(user)

    click_link "Create"
    fill_in "Title", with: "Romeo and Juliet"
    fill_in "Synopsis", with: "The only title I could think of"
    attach_file 'Image', "/Users/jojograndjojo/Projects2/TFAA/lib/assets/owl jolson.jpeg"
    click_button "submit"


    fill_in "Description", with: "I really hope this works"
    click_button "submit"

    expect(page).to have_content "I really hope this works"
    expect(page).to have_content "Romeo and Juliet"
  end


  scenario "user can add choices to a chapter" do
    FactoryGirl.create(:choice, option: "Start", chapter_id: nil)
    user = create(:user)
    log_in_with(user)

    click_link "Create"
    fill_in "Title", with: "Romeo and Juliet"
    fill_in "Synopsis", with: "The only title I could think of"
    attach_file 'Image', "/Users/jojograndjojo/Projects2/TFAA/lib/assets/owl jolson.jpeg"
    click_button "submit"


    fill_in "Description", with: "0"
    click_button "submit"
    click_link "0"

    expect(page).to have_content "Add a choice"
  end

  scenario "user has to create a chapter when a choice is created" do
    FactoryGirl.create(:choice, option: "Start", chapter_id: nil)
    user = create(:user)
    log_in_with(user)

    click_link "Create"
    fill_in "Title", with: "Romeo and Juliet"
    fill_in "Synopsis", with: "The only title I could think of"
    attach_file 'Image', "/Users/jojograndjojo/Projects2/TFAA/lib/assets/owl jolson.jpeg"
    click_button "submit"


    fill_in "Description", with: "0"
    click_button "submit"
    click_link "0"

    fill_in "Option", with: "it did!"
    click_button "submit"
    expect(page).to have_content "Add a chapter"
  end
end
