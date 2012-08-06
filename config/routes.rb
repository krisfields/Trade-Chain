TradeChain::Application.routes.draw do

  # get "results/show"

  # get "trades/new"

  # get "trades/create"

  # get "trades/index"

  # get "trades/edit"

  # get "trades/update"

  # get "trades/destroy"

  # get "trades/show"

  # get "trade/new"

  # get "trade/create"

  # get "trade/index"

  # get "trade/edit"

  # get "trade/update"

  # get "trade/destroy"

  # get "trade/show"

  get "images/new"

  get "images/edit"

  get "images/create"

  get "images/index"

  get "images/update"

  resources :images

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  resources :wants, :path => "StuffIWant"
  resources :possessions, :path => "Explore/FindStuff", :except => [:new, :edit]
  resources :possessions, :path => "StuffIOwn", :only => [:new, :edit]
  resources :trades, :path => "Explore/"
  match "/Explore/:id/results" => "trades#results"
  devise_for :users
  resources :users, :path => "", :only => [:index, :show]

  
  #match "/:name" => "users#show"
end
