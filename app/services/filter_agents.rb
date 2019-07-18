class FilterAgents
  attr_reader :scope
  attr_reader :criteria

  def initialize(scope:, criteria: {})
    @scope = scope
    @criteria = criteria
  end

  def filter
    if @criteria[:state].present?
      @scope = @scope.licensed_in_state(criteria[:state])
    end

    if @criteria[:industry].present?
      @scope = @scope.by_industry(criteria[:industry])
    end

    if phone_number.present?
      @scope = @scope.by_phone_number(phone_number)
    end

    @scope
  end

  private

  def phone_number
    @phone_number ||= sanitize_phone_number(criteria[:phone_number] || '')
  end

  def sanitize_phone_number(phone_number)
    phone_number.strip.tr('^0-9', '')
  end
end
