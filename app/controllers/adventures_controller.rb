class AdventuresController < ApplicationController

  before_action :authenticate_user!, :except => [:index, :show]

  def index
    @adventures = Adventure.all
  end

  def show
    @adventure = Adventure.find(params[:id])
    @first_chapter = Chapter.where(adventure_id: @adventure.id).first
  end

  def new
    @adventure = Adventure.new
  end

  def create
    @adventure = Adventure.new(adventure_params)
    @adventure.user_id = current_user.id
    if @adventure.save
      @adventure_id = @adventure.id
      redirect_to new_adventure_chapter_path(@adventure)
    else
      flash[:error] = "Title needs to be unique"
      redirect_to new_adventure_path
    end
  end

  def design
    @adventure = Adventure.find(params[:adventure_id])
    is_the_user_the_owner(@adventure, current_user)
    @chapters = Chapter.where(adventure_id: @adventure.id)
    unless @chapters[0]
      redirect_to new_adventure_chapter_path(@adventure)
    end
    @adventure_id = @adventure.id
  end


  private

  def adventure_params
    params.require(:adventure).permit(:title, :synopsis, :image)
  end

  def is_the_user_the_owner(adventure, user)
    if adventure.user_id != user.id
      flash[:notice] = "Cannot edit another user's story"
      redirect_to adventure_path(@adventure)
    end
  end

end
