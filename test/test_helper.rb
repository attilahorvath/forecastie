ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'webmock/minitest'

WebMock.disable_net_connect! allow_localhost: true

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def setup
    stub_request(:get, /openweathermap\.org/).to_return(status: 200, body: File.open("#{Rails.root}/test/fixtures/forecasts.json", 'r').read, headers: {})
  end
end
