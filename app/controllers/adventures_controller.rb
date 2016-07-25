class AdventuresController < ApplicationController
  def show
    @adventures = Adventure.all
  end
end
