require 'rails_helper'

describe 'GET #show' do
  xscenario "redirects to home page when user is logged out" do
    adventure = create(:adventure)
    chapter = create(:chapter, adventure_id: adventure.id)

    subject {get :show, :adventures => adventure.id, :chapters => chapter.id}

    expect(subject).to redirect_to '/'
  end
end
