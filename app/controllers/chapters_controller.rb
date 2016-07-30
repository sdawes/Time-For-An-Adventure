class ChaptersController < ApplicationController

  before_action :authenticate_user!

  def show
    if current_user
      @chapter = Chapter.find(params[:id])
      @choices = Choice.where(chapter_id: "#{@chapter.id}")
    else
      redirect_to '/'
    end
  end
end
