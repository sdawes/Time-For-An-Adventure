class ChaptersController < ApplicationController

  before_action :authenticate_user!

  def show
      @chapter = Chapter.find(params[:id])
      @choices = Choice.where(chapter_id: "#{@chapter.id}")
  end

  def new
    @adventure = Adventure.find(params[:adventure_id])
    @chapter = Chapter.new
  end

  def create
    @adventure = Adventure.find(params[:adventure_id])
    @chapter = Chapter.new(chapter_params)
    @chapter.adventure_id = @adventure.id
    @chapter.save
    @adventure_id = @adventure.id
    @chapter_id = @chapter.id
    redirect_to new_adventure_chapter_choice_path(@adventure_id, @chapter_id)
  end

  private

  def chapter_params
    params.require(:chapter).permit(:description)
  end

end
