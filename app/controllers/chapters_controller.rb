class ChaptersController < ApplicationController

  before_action :authenticate_user!

  def show
    @chapter = Chapter.find(params[:id])
    @choices = Choice.where(chapter_id: "#{@chapter.id}")
  end
end
