require 'test_helper'

class AsciiControllerTest < ActionDispatch::IntegrationTest
  test "should get example" do
    get ascii_example_url
    assert_response :success
  end

end
