class ForecastsController < ApplicationController
  def index
    @city = params[:city]

    @forecasts = Forecast.fetch! city: @city
  end

  def show
    @city = params[:city]
    @timestamp = params[:timestamp].to_i

    @forecast = Forecast.fetch_one! city: @city, timestamp: @timestamp
  end
end
