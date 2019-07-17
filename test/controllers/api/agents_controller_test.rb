require 'test_helper'

class Api::AgentsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    james = Agent.find_by_name('James Willhelm')
    get api_agent_url(james)

    assert_equal response.body, james.to_json
    assert_response :success
  end
end
