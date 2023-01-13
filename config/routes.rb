Rails.application.routes.draw do
  
  # root "articles#index"
  root "articles#index"
  # Map all "routers" from model articles
  resources :articles do
    resources :comments
  end
end
