class ChaptersController < ApplicationController

  before_action :authenticate_user!

  def show
    @adventure = Adventure.find(params[:adventure_id])

    @all_chapters = Chapter.count

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
    @choice = Choice.where(id: @chapter.parent_choice_id).first
    redirect_to edit_adventure_chapter_choice_path(@adventure,@chapter,@choice)
  end


  def branch_destroy
    @adventure = Adventure.find(params[:adventure_id])
    @chapter = Chapter.find(params[:chapter_id])

    children_chapters(@chapter).each do |chapter|
      mark_to_destroy(chapter)
    end
    Chapter.where(to_destroy: true).destroy_all
    redirect_to adventure_design_path(@adventure)
  end

  def children_chapters(chapter)
    chapters = [chapter]
    choices = Choice.where(chapter_id: chapter.id)

    choices.each do |choice|
      chapters << child_chapter_children(choice)
    end
    chapters.flatten
  end

  def child_chapter_children(choice)
    chapter = Chapter.where(parent_choice_id: choice.id).first
    chapters = [chapter, children_chapters(chapter)]
  end

  def mark_to_destroy(chapter)
    chapter.update(to_destroy: true)
  end

  private

  def chapter_params
    params.require(:chapter).permit(:description)
  end

end
