class Api::AgentsController < ApplicationController
  def show
    @agent = Agent.find(params[:id])
    render json: @agent, status: 200
  end
end
