require 'test_helper'

class ForecastsControllerTest < ActionController::TestCase
  test 'should get query' do
    get :query

    assert_response :success
  end

  test 'should get index' do
    get :index, city: 'Dublin'

    assert_response :success
    assert_not_nil assigns(:city)
    assert_not_nil assigns(:forecasts)
  end

  test 'should get show' do
    get :show, city: 'Dublin', timestamp: 1460030400

    assert_response :success
    assert_not_nil assigns(:city)
    assert_not_nil assigns(:timestamp)
    assert_not_nil assigns(:forecast)
  end
end
