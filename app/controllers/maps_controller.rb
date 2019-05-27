class MapsController < ApplicationController
  def index
    @maps = Map.all
  end

  def show
    @map = Map.find(params[:id])
  end

  def new
    @map = Map.new
  end

  def create
    @map = Map.create(map_params)
    redirect_to maps_path
  end

  private

  def map_params
    params.require(:map).permit(:name, :description)
  end
end
