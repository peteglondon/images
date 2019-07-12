Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    post '/convert', to: 'conversion#convert'
  end
end
