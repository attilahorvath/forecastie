class Forecast
  include ActiveModel::Model

  attr_accessor :created_at, :timestamp, :temperature, :min_temperature,
                :max_temperature, :night_temperature, :evening_temperature,
                :morning_temperature, :pressure, :humidity, :description,
                :wind_speed, :wind_direction, :cloudiness

  def self.fetch!(options = {})
    options[:count] ||= 16
    hash = get_forecast_hash options

    return nil unless hash

    hash['list'].map { |item| initialize_from_hash(item) } if hash['list']
  end

  def self.fetch_one!(options = {})
    options[:count] ||= 16
    hash = get_forecast_hash options

    return nil unless hash

    list = hash['list']
    list = list.select{ |item| item['dt'] == options[:timestamp] } if list && options[:timestamp]

    initialize_from_hash list.first if list
  end

  def self.initialize_from_hash(hash = {})
    Forecast.new created_at: Time.at(hash['dt']),
                 timestamp: hash['dt'],

                 temperature: hash['temp']['day'].to_i,
                 min_temperature: hash['temp']['min'].to_i,
                 max_temperature: hash['temp']['max'].to_i,
                 night_temperature: hash['temp']['night'].to_i,
                 evening_temperature: hash['temp']['eve'].to_i,
                 morning_temperature: hash['temp']['morn'].to_i,

                 pressure: hash['pressure'].to_i,
                 humidity: hash['humidity'].to_i,

                 description: (hash['weather'].first['description'] if hash['weather'].first),

                 wind_speed: hash['speed'].to_i,
                 wind_direction: hash['deg'].to_i,
                 cloudiness: hash['clouds'].to_i
  end

  private

  def self.get_forecast_hash(options = {})
    count = options[:count] || 1
    city = options[:city]

    begin
      OpenWeather::ForecastDaily.city(city, units: 'metric', cnt: count, APPID: Rails.application.secrets.open_weather_appid)
    rescue
      nil
    end
  end
end
