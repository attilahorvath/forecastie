class Forecast
  include ActiveModel::Model

  attr_accessor :city, :created_at, :temperature, :min_temperature, :max_temperature, :humidity

  def fetch!
    hash = get_forecast_hash

    initialize_from_hash hash['list'].first if hash['list']
  end

  def fetch_many!(count = 16)
    hash = get_forecast_hash count

    hash['list'].map { |item| Forecast.new.initialize_from_hash(item) } if hash['list']
  end

  def initialize_from_hash(attributes = {})
    self.created_at = Time.at attributes['dt']

    self.temperature = attributes['temp']['day']
    self.min_temperature = attributes['temp']['min']
    self.max_temperature = attributes['temp']['max']

    self.humidity = attributes['humidity']

    self
  end

  private

  def get_forecast_hash(count = 1)
    OpenWeather::ForecastDaily.city(city, units: 'metric', cnt: count, APPID: Rails.application.secrets.open_weather_appid)
  end
end
