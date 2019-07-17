Rails.application.routes.draw do
  namespace :api do
    resources :agents, only: :show
  end
end
