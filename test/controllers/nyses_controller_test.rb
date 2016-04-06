require 'test_helper'

class NysesControllerTest < ActionController::TestCase
  setup do
    @nyse = nyses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:nyses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create nyse" do
    assert_difference('Nyse.count') do
      post :create, nyse: { alive: @nyse.alive, country: @nyse.country, ipo: @nyse.ipo, list_type: @nyse.list_type, market: @nyse.market, name: @nyse.name, sector: @nyse.sector, symbol: @nyse.symbol }
    end

    assert_redirected_to nyse_path(assigns(:nyse))
  end

  test "should show nyse" do
    get :show, id: @nyse
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @nyse
    assert_response :success
  end

  test "should update nyse" do
    patch :update, id: @nyse, nyse: { alive: @nyse.alive, country: @nyse.country, ipo: @nyse.ipo, list_type: @nyse.list_type, market: @nyse.market, name: @nyse.name, sector: @nyse.sector, symbol: @nyse.symbol }
    assert_redirected_to nyse_path(assigns(:nyse))
  end

  test "should destroy nyse" do
    assert_difference('Nyse.count', -1) do
      delete :destroy, id: @nyse
    end

    assert_redirected_to nyses_path
  end
end
