class Api::AgentsController < ApplicationController
  def index
    @agents = filter_agents(Agent.all)
    render json: @agents, status: 200
  end

  def show
    @agent = Agent.find(params[:id])
    render json: @agent, status: 200
  end

  private

  def filter_agents(agents)
    ::FilterAgents.new(scope: agents, criteria: search_params).filter
  end

  def search_params
    @search_params ||= params.permit(:state, :industry, :phone_number)
  end
end
