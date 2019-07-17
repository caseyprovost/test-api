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
    if search_params[:state].present?
      agents = agents.joins(:licenses).where(licenses: { state: search_params[:state] })
    end

    if search_params[:industry].present?
      agents = agents.joins(carriers: [:industries]).where(industries: { name: search_params[:industry] })
    end

    agents
  end

  def search_params
    @search_params ||= params.permit(:state, :industry)
  end
end
