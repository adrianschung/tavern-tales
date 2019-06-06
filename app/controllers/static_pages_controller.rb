# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def index
    @recent_maps = Map.order(created_at: :desc).first(2)
  end
end
