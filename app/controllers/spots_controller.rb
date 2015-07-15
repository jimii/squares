class SpotsController < ApplicationController

  before_action :set_spot, only: [:update]

  def update
    respond_to do |format|
      if @spot.update(spot_params)
        format.json { render json: @spot, status: :ok, location: @spot }
      else
        format.json { render json: @spot.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @spot = Spot.new(spot_params)

    respond_to do |format|
      if @spot.save
        format.json { render json: @spot, status: :created, location: @spot }
      else
        format.json { render json: @spot.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_spot
    @spot = Spot.find(params[:id])
  end

  def spot_params
    params.require(:spot).permit(:name, :position_x, :position_y)
  end


end