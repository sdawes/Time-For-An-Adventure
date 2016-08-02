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
      @choice = Choice.where(option: "Start", chapter_id: nil).first
    else
      @choice = Choice.all.last
    end
      @chapter = Chapter.new(chapter_params)
      @chapter.adventure_id = @adventure.id
      @chapter.parent_choice_id = @choice.id
      @chapter.save
    redirect_to adventure_design_path
  end

  def edit
    @adventure = Adventure.find(params[:adventure_id])
    @chapter = Chapter.find(params[:id])
  end

  def update
    @adventure = Adventure.find(params[:adventure_id])
    @chapter = Chapter.find(params[:id])
    @chapter.update(chapter_params)
    redirect_to adventure_design_path(@adventure)
  end



  def destroy_children_chapters
    @chapter = Chapter.find(params[:id])
    find_children_chapters(@chapter).destroy_all
  end

  def find_children_chapters(chapter)
    @choices = Choice.where(chapter_id: chapter.id)
    @chapters = [chapter, find_chapters_from_choices(@choices)]
  end

  def find_chapters_from_choices(array_of_choices)
    chapters = []
    array_of_choices.each do |choice|
      chapters << Chapter.where(parent_choice_id: choice.id)
      chapters.flatten
    end

  end

  def destroy
    @chapter = Chapter.find(params[:id])
    @chapter.destroy
  end



  private

  def chapter_params
    params.require(:chapter).permit(:description)
  end

end
