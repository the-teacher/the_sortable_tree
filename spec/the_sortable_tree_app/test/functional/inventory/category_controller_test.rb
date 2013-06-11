require 'test_helper'

class Inventory::CategoryControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get manage" do
    get :manage
    assert_response :success
  end

end
