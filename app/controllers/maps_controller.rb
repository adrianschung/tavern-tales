# frozen_string_literal: true

class MapsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  def index
    @maps = Map.paginate(page: params[:page], per_page: 10)
  end

  def show; end

  def new
    @map = Map.new
  end

  def create
    @map = current_user.maps.create(map_params)
    if @map.valid?
      flash[:notice] = "Map successfully created"
      redirect_to map_path(@map)
    else
      flash[:alert] = "Something went wrong - Try again later"
      render :index, status: :unprocessable_entity
    end
  end

  def edit
    @map = Map.find(params[:id])
    if current_user != current_map.user
      return render plain: 'Not Allowed',
                    status: :forbidden
    end
  end

  def update
    if current_user != current_map.user
      return render plain: 'Not Allowed',
                    status: :forbidden
    end
    current_map.update_attributes(map_params)
    if current_map.valid?
      flash[:notice] = "Map successfully updated"
      redirect_to map_path(current_map)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    current_map.destroy
    redirect_to maps_path
  end

  def tagged
    if params[:tag].present?
      @maps = Map.tagged_with(params[:tag])
    else
      @maps = Map.all
    end
  end

  private

  helper_method :current_map

  def current_map
    @current_map ||= Map.find(params[:id])
  end

  def map_params
    params.require(:map).permit(:name, :description, :picture, :tag_list)
  end
end
