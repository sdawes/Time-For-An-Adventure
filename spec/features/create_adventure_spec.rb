require 'rails_helper'

feature "Creating Chapter" do
  scenario "user can see a create link" do
    user = create(:user)
    log_in_with(user)
    expect(page).to have_link "Create"
  end

  scenario "user can access a adventure design page" do
    user = create(:user)
    log_in_with(user)
    click_link "Create"
    expect(page).to have_content "Adventure Tree"
  end
end
