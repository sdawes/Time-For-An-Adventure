class ChaptersController < ApplicationController

  before_action :authenticate_user!

  def show
    @adventure = Adventure.find(params[:adventure_id])

    @chapter = Chapter.find(params[:id])

    @choices = Choice.where(chapter_id: @chapter.id)

    @chapters = []

    @choices.each do |choice|
      @chapters << [choice, Chapter.where(parent_choice_id: choice.id).first]
    end

  end

  def new
    @adventure = Adventure.find(params[:adventure_id])
    @chapter = Chapter.new
  end

  def create
    @adventure = Adventure.find(params[:adventure_id])

    if Chapter.where(adventure_id: params[:adventure_id]).empty?
      @choice = Choice.create(option: "start")
      @chapter = Chapter.new(chapter_params)
      @chapter.adventure_id = @adventure.id
      @chapter.parent_choice_id = @choice.id
      @chapter.save
    else
      @choice = Choice.all.last
      @chapter = Chapter.new(chapter_params)
      @chapter.adventure_id = @adventure.id
      @chapter.parent_choice_id = @choice.id
      @chapter.save
    end
    redirect_to adventure_design_path
  end

  private

  def chapter_params
    params.require(:chapter).permit(:description)
  end

end
