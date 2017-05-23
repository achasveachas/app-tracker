Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      root "auth#ping"
      resources :users, only: [:create, :show] do

        resources :applications, only: [:index, :show, :create, :update, :destroy]

      end
      post'/auth', to: "auth#login"
      post'/auth/refresh', to: "auth#refresh"

    end
  end

end
