class MapsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
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
    @map = current_user.maps.create(map_params)
    redirect_to maps_path
  end

  def edit
    @map = Map.find(params[:id])

  def update
    @map = Map.find(params[:id])
    return unless owned?(@map)
    @map.update_attributes(map_params)
  end

  private

  def map_params
    params.require(:map).permit(:name, :description)
  end
end
