Rails.application.routes.draw do
  namespace :api do
    resources :agents, only: [:index, :show]
  end
end
