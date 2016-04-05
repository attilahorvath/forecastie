class ForecastsController < ApplicationController
  def new
    @forecast = Forecast.new
  end

  def create
    @forecast = Forecast.new forecast_params
    @forecasts = @forecast.fetch_many!
  end

  def show
    @forecast = Forecast.new forecast_params
    @forecast.fetch!
  end

  private

  def forecast_params
    params[:forecast].permit(:city)
  end
end
