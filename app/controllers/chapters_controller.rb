class ChaptersController < ApplicationController
  def show
    if current_user
      @chapter = Chapter.find(params[:id])
      @choices = Choice.where(chapter_id: "#{@chapter.id}")
    else
      redirect_to '/'
    end
  end
end
