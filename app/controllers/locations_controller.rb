class LocationsController < ApplicationController
  def index
    @locations.all
  end

  def show
    @location.find(params[:id])
  end
end
