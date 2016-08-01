class AdventuresController < ApplicationController
  def index
    @adventures = Adventure.all
  end

  def show
    @adventure = Adventure.find(params[:id])
    @first_chapter = Chapter.where(adventure_id: @adventure.id).first
  end

  def new
    @adventure = Adventure.new
  end

  def create
    @adventure = Adventure.create(adventure_params)
    @adventure_id = @adventure.id
    redirect_to adventure_design_path(@adventure_id)
  end

  def design
    @adventure = Adventure.find(params[:adventure_id])
    @chapters = Chapter.where(adventure_id: @adventure.id)
    @adventure_id = @adventure.id
  end


  private

  def adventure_params
    params.require(:adventure).permit(:title, :synopsis)
  end
end
