require "test_helper"

class Api::PoliciesControllerTest < ActionDispatch::IntegrationTest
  test "can creates new policies" do
    james = Agent.find_by_name("James Willhelm")
    beer_tasting = Industry.find_by_name("Professional Beer Taste-Tester")
    new_york_mutual = Carrier.find_by_name("New York City Mutual Insurance")

    post api_policies_url, params: {
      format: "json",
      policy: {
        agent_id: james.id,
        industry_id: beer_tasting.id,
        carrier_id: new_york_mutual.id,
        policy_holder: "Peter Parker",
        premium_amount: "1000000.00",
      },
    }

    last_policy = Policy.find_by(policy_holder: "Peter Parker")
    assert last_policy.present?

    expected_json = last_policy.to_json(
      only: [:id, :policy_holder, :premium_amount, :updated_at],
      include: {
        agent: {only: [:id, :name]},
        carrier: {only: [:id, :name]},
        industry: {only: [:id, :name]},
      }
    )

    assert_equal expected_json, response.body
    assert_response :success
  end
end
