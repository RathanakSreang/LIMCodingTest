Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      post 'pages/fetch' => 'pages#fetch'
      get 'pages/list' => 'pages#list'
    end
  end
end
