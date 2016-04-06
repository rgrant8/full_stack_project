require 'test_helper'

class AmexesControllerTest < ActionController::TestCase
  setup do
    @amex = amexes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:amexes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create amex" do
    assert_difference('Amex.count') do
      post :create, amex: { alive: @amex.alive, country: @amex.country, ipo: @amex.ipo, list_type: @amex.list_type, market: @amex.market, name: @amex.name, sector: @amex.sector, symbol: @amex.symbol }
    end

    assert_redirected_to amex_path(assigns(:amex))
  end

  test "should show amex" do
    get :show, id: @amex
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @amex
    assert_response :success
  end

  test "should update amex" do
    patch :update, id: @amex, amex: { alive: @amex.alive, country: @amex.country, ipo: @amex.ipo, list_type: @amex.list_type, market: @amex.market, name: @amex.name, sector: @amex.sector, symbol: @amex.symbol }
    assert_redirected_to amex_path(assigns(:amex))
  end

  test "should destroy amex" do
    assert_difference('Amex.count', -1) do
      delete :destroy, id: @amex
    end

    assert_redirected_to amexes_path
  end
end
