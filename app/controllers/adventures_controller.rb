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
    redirect_to adventure_design_path(@adventure.id)
  end

  def design
    @adventure = Adventure.find(params[:adventure_id])
    @adventure_id = @adventure.id
  end

  def content
    @adventure = Adventure.find(params[:adventure_id])
    @chapter = Chapter.new
    @choice1 = Choice.new
    @choice2 = Choice.new
  end

  private

  def adventure_params
    params.require(:adventure).permit(:title, :synopsis)
  end
end
