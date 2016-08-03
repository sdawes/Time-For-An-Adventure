class ChaptersController < ApplicationController

  before_action :authenticate_user!

  def show
    game = Game.where(adventure_id: params[:adventure_id].to_i, user_id: current_user.id).first
    if game
      update_game(game)
      @chapter = Chapter.find(game.chapters.split(',').last)
      @choices = Choice.where(chapter_id: @chapter.id)
      @chapters = []
      @choices.each do |choice|
        @chapters << [choice, Chapter.where(parent_choice_id: choice.id).first]
      end
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
      @choice = Choice.create(option: "start")
    else
      @choice = Choice.all.last
    end
      @chapter = Chapter.new(chapter_params)
      @chapter.adventure_id = @adventure.id
      @chapter.parent_choice_id = @choice.id
      @chapter.save
    redirect_to adventure_design_path
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
