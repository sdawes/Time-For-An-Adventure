class AdventuresController < ApplicationController
  def index
    @adventures = Adventure.all
  end

  def show
    @adventure = Adventure.find(params[:id])
    @adventure_id = @adventure.id

    if current_user
      @redirection = "/adventures/#{@adventure_id}/chapters/1"
    else
      @redirection = "/users/sign_up"
    end

  end
end
