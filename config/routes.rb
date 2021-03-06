# Rails.application.routes.draw do
#   resources :users do
#     resources :boards, only: [:index]
#   end
#
#   resources :boards
# end


Rails.application.routes.draw do

  concern :api_base do
    resources :users do
      resources :boards, only: [:index]
    end
    resources :boards
  end

    namespace :v1 do
      concerns :api_base
    end

    namespace :v2 do
      concerns :api_base
    end

    namespace :v3 do
      concerns :api_base
      post 'user_token' => 'user_token#create'
    end

    namespace :v4 do
      concerns :api_base
    end
end