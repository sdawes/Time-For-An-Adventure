class ChoicesController < ApplicationController
  NUMBER_OF_CHOICES = 2

  def new
    @adventure = Adventure.find(params[:adventure_id])
    @chapter = Chapter.find(params[:chapter_id])
    @choices = []
    NUMBER_OF_CHOICES.times do
      @choices << Choice.new
    end
  end

  def create
    params["choice"].each do |choice|
        Choice.create(choice_params)
    end
  end

  def bulk_create
    choice_params.values.each do |choice_value|
      choice = Choice.new
      choice.chapter_id = params[:chapter_id]
      choice.option = choice_value
      choice.save
    end
    @adventure = Adventure.find(params[:adventure_id])
    redirect_to adventure_design_path(@adventure)
  end

  private

  def choice_params
    params.require(:choices).permit(:option_0, :option_1)
  end
end
