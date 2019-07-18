class Api::PoliciesController < ApplicationController
  # For the sake of speed, we are using the default to_json implementation here.
  # As time goes on and more endpoints are added we would standardize around a
  # serialization tool such as jsonapi-rb, fast_jsonapi, or Graphiti.
  def create
    @policy = Policy.new(create_params)

    if @policy.save
      render json: @policy.to_json(
        only: [:id, :policy_holder, :premium_amount, :updated_at],
        include: {
          agent: {only: [:id, :name]},
          carrier: {only: [:id, :name]},
          industry: {only: [:id, :name]},
        }
      ), status: 201
    else
      render json: @policy.errors, status: 422
    end
  end

  private

  def create_params
    params.require(:policy).permit(
      :policy_holder,
      :premium_amount,
      :agent_id,
      :carrier_id,
      :industry_id
    )
  end
end
