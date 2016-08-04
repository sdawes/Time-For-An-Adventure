class ChaptersController < ApplicationController

  before_action :authenticate_user!

  def show
    game = Game.where(adventure_id: params[:adventure_id].to_i, user_id: current_user.id).first
    if game
      update_game(game)
      @chapter = Chapter.find(game.chapters.split(',').last)
    else
      Game.create(chapters: params[:id], choices: "", adventure_id: params[:adventure_id], user_id: current_user.id)
      @chapter = Chapter.find(params[:id])
      @choices = Choice.where(chapter_id: @chapter.id)
      @chapters = []
      @choices.each do |choice|
        @chapters << [choice, Chapter.where(parent_choice_id: choice.id).first]
      end
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
    @choices = Choice.where(chapter_id: @chapter.id)

    if @choices == []
      mark_to_destroy(@chapter)
    else
      children_chapters(@chapter, @choices).each do |chapter|
        mark_to_destroy(chapter)
      end
    end

    Chapter.where(to_destroy: true).destroy_all
    redirect_to adventure_design_path(@adventure)
  end

  def children_chapters(chapter, choices)
    chapters = [chapter]
    choices.each do |choice|
    chapters << child_chapter_children(choice)
    end
    chapters.flatten
  end

  def child_chapter_children(choice)
    chapter = Chapter.where(parent_choice_id: choice.id)
    if chapter == []
      chapter
    else
      choices = Choice.where(chapter_id: chapter.first.id)
      chapters = [chapter.first, children_chapters(chapter.first, choices)]
    end
  end

  def mark_to_destroy(chapter)
    chapter.update(to_destroy: true)
  end

  private

  def chapter_params
    params.require(:chapter).permit(:description)
  end

  def update_game(game)
    choice_id = Chapter.find(params[:id]).parent_choice_id
    game.update(chapters: "#{game.chapters},#{params[:id]}", choices: "#{game.choices},#{choice_id}") if choice_id
  end

end
