require 'test_helper'

class FilterAgentsTest < ActiveSupport::TestCase
  test 'filters by state agents are licensed in' do
    filterer = FilterAgents.new(scope: Agent.all, criteria: { state: 'OH' })
    results = filterer.filter
    assert_equal Agent.licensed_in_state('OH').count, results.count
  end

  test 'filters by industries the agent participates in' do
    filterer = FilterAgents.new(scope: Agent.all, criteria: { industry: 'Professional Beer Taste-Tester' })
    results = filterer.filter
    assert_equal Agent.by_industry('Professional Beer Taste-Tester').count, results.count
  end

  test 'filters by agent phone number' do
    filterer = FilterAgents.new(scope: Agent.all, criteria: { phone_number: '6161112222' })
    results = filterer.filter
    assert_equal Agent.by_phone_number('6161112222').count, results.count
  end
end
