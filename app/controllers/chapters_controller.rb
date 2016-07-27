class ChaptersController < ApplicationController
  def show
    @chapter = Chapter.find(params[:id])
    @choices = Choice.where(chapter_id: "#{@chapter.id}")
  end
end
