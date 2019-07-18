require "test_helper"

class Api::AgentsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    james = Agent.find_by_name("James Willhelm")
    get api_agent_url(james)

    assert_equal james.to_json, response.body
    assert_response :success
  end

  test "should search agents by state" do
    james = Agent.find_by_name("James Willhelm")
    get api_agents_url(state: "OH")

    agents = JSON.parse(response.body)
    assert_equal 1, agents.count
    assert_equal james.id, agents.first["id"]
    assert_response :success
  end

  test "should search agents by industry" do
    bruce = Agent.find_by_name("Bruce Banner")
    get api_agents_url(industry: "Professional Beer Taste-Tester")

    agents = JSON.parse(response.body)
    assert_equal 1, agents.count
    assert_equal bruce.id, agents.first["id"]
    assert_response :success
  end

  test "should search agents by state AND industry" do
    bruce = Agent.find_by_name("Bruce Banner")
    get api_agents_url(industry: "Professional Beer Taste-Tester", state: "MI")

    agents = JSON.parse(response.body)
    assert_equal 1, agents.count
    assert_equal bruce.id, agents.first["id"]
    assert_response :success
  end

  test "should search agents by phone number" do
    tony = Agent.find_by_name("Tony Stark")
    get api_agents_url(phone_number: "6161112222")

    agents = JSON.parse(response.body)
    assert_equal 1, agents.count
    assert_equal tony.id, agents.first["id"]
    assert_response :success
  end
end
