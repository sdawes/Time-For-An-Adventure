class GamesController < ApplicationController
  def delete
    game = Game.where(adventure_id: params[:adventure_id], user_id: current_user.id).first
    game.destroy
    @first_chapter = Chapter.where(adventure_id: params[:adventure_id]).first
    redirect_to adventure_chapter_path(params[:adventure_id], @first_chapter)
  end
end
