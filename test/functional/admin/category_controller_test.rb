require 'test_helper'

class Admin::CategoryControllerTest < ActionController::TestCase
  test "should get assign_product_to_category" do
    get :assign_product_to_category
    assert_response :success
  end

end
