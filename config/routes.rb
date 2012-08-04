TradeChain::Application.routes.draw do

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users, :only => [:index]
  resources :wants
  resources :possessions
  
  match "/:name" => "users#show"
end
