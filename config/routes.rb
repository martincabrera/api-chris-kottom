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

  subdomain = ENV.fetch('API_SUBDOMAIN', '')
  constraints subdomain: subdomain do
    namespace :v1 do
      concerns :api_base
    end

    namespace :v2 do
      concerns :api_base
    end
  end
end