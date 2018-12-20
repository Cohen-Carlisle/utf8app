require 'test_helper'

class Utf8ControllerTest < ActionDispatch::IntegrationTest
  test "should get example" do
    get utf8_example_url
    assert_response :success
  end

end
