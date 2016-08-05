require "rails_helper"

feature "Updating adventures" do

  scenario "lets a user update an adventure" do
    FactoryGirl.create(:choice, option: "Start", chapter_id: nil)
    user = create(:user)

    log_in_with(user)
    click_link "Create"

    fill_in "Title", with: "Marlon's story"
    fill_in "Synopsis", with: "Marlon buy trousers"
    attach_file 'Image', "/Users/jojograndjojo/Projects2/TFAA/lib/assets/owl jolson.jpeg"
    click_button "submit"


    fill_in "Description", with: "Just fucking Marlon goes to the shop"
    click_button "submit"
    expect(page).to have_link "Update Chapter"
  end

  scenario "lets a user update an adventure" do
    FactoryGirl.create(:choice, option: "Start", chapter_id: nil)
    user = create(:user)

    log_in_with(user)
    click_link "Create"

    fill_in "Title", with: "Marlon's story"
    fill_in "Synopsis", with: "Marlon buy trousers"
    attach_file 'Image', "/Users/jojograndjojo/Projects2/TFAA/lib/assets/owl jolson.jpeg"
    click_button "submit"


    fill_in "Description", with: "Just fucking Marlon goes to the shop"
    click_button "submit"

    click_link "Update Chapter"
    expect(page).to have_content "Edit your chapter"
  end

  scenario "lets a user update an adventure" do
    FactoryGirl.create(:choice, option: "Start", chapter_id: nil)
    user = create(:user)

    log_in_with(user)
    click_link "Create"

    click_link "Create"
    fill_in "Title", with: "Marlon's story"
    fill_in "Synopsis", with: "Marlon buy trousers"
    attach_file 'Image', "/Users/jojograndjojo/Projects2/TFAA/lib/assets/owl jolson.jpeg"
    click_button "submit"


    fill_in "Description", with: "Just fucking Marlon goes to the shop"
    click_button "submit"

    click_link "Update Chapter"

    expect(page).to have_content "Edit your chapter"
  end

end
