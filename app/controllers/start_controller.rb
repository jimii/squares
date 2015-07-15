class StartController < ApplicationController

  # start screen
  #
  # * get spots

  def index
    @spots = Spot.all
  end

end