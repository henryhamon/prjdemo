Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do 
    namespace :v1 do
      resources :projects do
        resources :notes
        get :finish, on: :member
        post :finish_all, on: :collection
      end
    end
  end
end
