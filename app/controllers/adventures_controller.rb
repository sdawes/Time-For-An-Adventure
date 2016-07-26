class AdventuresController < ApplicationController
  def index
    @adventures = Adventure.all
  end

  def show
  end
end
