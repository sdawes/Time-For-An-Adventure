class ChoicesController < ApplicationController
  NUMBER_OF_CHOICES = 2

  def new
    @adventure = Adventure.find(params[:adventure_id])
    @chapter = Chapter.find(params[:chapter_id])
    @choice = Choice.new
  end

  def create
    @adventure = Adventure.find(params[:adventure_id])
    redirect_to new_adventure_chapter_path(@adventure)
  end

  # def bulk_create
  #   choice_params.values.each do |choice_value|
  #     choice = Choice.new
  #     choice.chapter_id = params[:chapter_id]
  #     choice.option = choice_value
  #     choice.save
  #   end
  #   @adventure = Adventure.find(params[:adventure_id])
  #   redirect_to adventure_design_path(@adventure)
  # end

  private

  def choice_params
    params.require(:choice).permit(:option)
  end
end
