class ChoicesController < ApplicationController


  def new
    @adventure = Adventure.find(params[:adventure_id])
    @chapter = Chapter.find(params[:chapter_id])
    @choice = Choice.new
  end

  def create
    @adventure = Adventure.find(params[:adventure_id])
    @chapter = Chapter.find(params[:chapter_id])
    @choice = Choice.new(choice_params)
    @choice.chapter_id = @chapter.id
    @choice.save
    redirect_to new_adventure_chapter_path(@adventure)
  end

  def edit
    @adventure = Adventure.find(params[:adventure_id])
    @chapter = Chapter.find(params[:chapter_id])
    @choice = Choice.find(params[:id])
  end

  def update
    @choice = Choice.find(params[:id])
    @choice.update(choice_params)
    @adventure = Adventure.find(params[:adventure_id])
    @chapter = Chapter.find(params[:chapter_id])
    redirect_to adventure_design_path(@adventure, @chapter)
  end

  private

  def choice_params
    params.require(:choice).permit(:option)
  end
end
