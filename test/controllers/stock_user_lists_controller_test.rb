require 'test_helper'

class StockUserListsControllerTest < ActionController::TestCase
  setup do
    @stock_user_list = stock_user_lists(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stock_user_lists)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stock_user_list" do
    assert_difference('StockUserList.count') do
      post :create, stock_user_list: { lists_id: @stock_user_list.lists_id, users_id: @stock_user_list.users_id }
    end

    assert_redirected_to stock_user_list_path(assigns(:stock_user_list))
  end

  test "should show stock_user_list" do
    get :show, id: @stock_user_list
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @stock_user_list
    assert_response :success
  end

  test "should update stock_user_list" do
    patch :update, id: @stock_user_list, stock_user_list: { lists_id: @stock_user_list.lists_id, users_id: @stock_user_list.users_id }
    assert_redirected_to stock_user_list_path(assigns(:stock_user_list))
  end

  test "should destroy stock_user_list" do
    assert_difference('StockUserList.count', -1) do
      delete :destroy, id: @stock_user_list
    end

    assert_redirected_to stock_user_lists_path
  end
end
