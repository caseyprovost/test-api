require "test_helper"

class PolicyTest < ActiveSupport::TestCase
  test "requires a policy holder" do
    policy = Policy.new
    assert_not policy.valid?
    assert policy.errors[:policy_holder].include?("can't be blank")
  end

  test "requires a premium amount" do
    policy = Policy.new
    assert_not policy.valid?
    assert policy.errors[:premium_amount].include?("can't be blank")
  end

  test "requires premium amount to be a number" do
    policy = Policy.new(premium_amount: "abc")
    assert_not policy.valid?
    assert policy.errors[:premium_amount].include?("is not a number")
  end
end
