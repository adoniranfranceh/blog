Rails.application.routes.draw do
  namespace :api, constraints: ->(req) { %w[json].include? req.format } do
    namespace :v1 do
      resources :articles, only: :index

      post "login", to: "sessions#create"
      delete "logout", to: "sessions#destroy"
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
