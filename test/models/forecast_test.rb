require 'test_helper'

class ForecastTest < ActiveSupport::TestCase
  test 'should fetch 16 forecast entries' do
    forecasts = Forecast.fetch! city: 'Dublin'

    assert_instance_of Array, forecasts
    assert_equal 16, forecasts.length
  end

  test 'should fetch one forecast entry' do
    forecast = Forecast.fetch_one! city: 'Dublin', timestamp: 1460030400

    assert_instance_of Forecast, forecast
  end

  test 'should deserialize from hash' do
    forecast = Forecast.fetch_one! city: 'Dublin', timestamp: 1460030400

    assert_equal 1460030400, forecast.timestamp
    assert_equal 8, forecast.temperature
    assert_equal 6, forecast.min_temperature
    assert_equal 9, forecast.max_temperature
    assert_equal 7, forecast.night_temperature
    assert_equal 8, forecast.evening_temperature
    assert_equal 6, forecast.morning_temperature
    assert_equal 1018, forecast.pressure
    assert_equal 96, forecast.humidity
    assert_equal 'light rain', forecast.description
    assert_equal 11, forecast.wind_speed
    assert_equal 312, forecast.wind_direction
    assert_equal 92, forecast.cloudiness
  end
end
