TradeChain::Application.routes.draw do

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  resources :wants, :path => "StuffIWant"
  resources :possessions, :path => "Everything"
  devise_for :users
  resources :users, :path => "", :only => [:index, :show]

  
  #match "/:name" => "users#show"
end
