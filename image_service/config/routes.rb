Rails.application.routes.draw do
  namespace :api, defaults: {format: :json} do
    resources :images, only: [:create, :show]
  end
end
