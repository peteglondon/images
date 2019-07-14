Rails.application.routes.draw do
  namespace :api do
    resources :images, only: [:create, :show]
  end
end
