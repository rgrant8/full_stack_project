require 'test_helper'

class WatchlistControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
