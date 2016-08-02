class ChoicesController < ApplicationController
  NUMBER_OF_CHOICES = 2

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

  private

  def choice_params
    params.require(:choice).permit(:option)
  end
end
