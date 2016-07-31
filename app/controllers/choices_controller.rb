class ChoicesController < ApplicationController
  def new
    @adventure = Adventure.find(params[:adventure_id])
    @chapter = Chapter.find(params[:chapter_id])
    @choices = []
    2.times do
      @choices << Choice.new
    end
  end

  def create
    p params
    params["choices"].each do |choice|
      if choice["option"] != ""
        Choice.create(choice_params(choice))
      end
    end
  end

  private

  def choice_params(params)
    params.permit(:option)
  end
end
