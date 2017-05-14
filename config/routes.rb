Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :users, only: [:create, :show] do

        resources :applications, only: [:index, :show, :create, :update]

      end
      post'/auth', to: "auth#login"
      post'/auth/refresh', to: "auth#refresh"

    end
  end

end
