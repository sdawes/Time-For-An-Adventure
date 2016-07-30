class AdventuresController < ApplicationController
  def index
    @adventures = Adventure.all
  end

  def show
    @adventure = Adventure.find(params[:id])
    @first_chapter = Chapter.where(adventure_id: @adventure.id).first
  end
end
