TradeChain::Application.routes.draw do

  # get "images/new"

  # get "images/edit"

  # get "images/create"

  # get "images/index"

  # get "images/update"

  resources :images

  authenticated :user do
    root :to => 'trades#index'
  end
  root :to => "trades#index"
  resources :wants, :path => "StuffIWant"
  resources :possessions, :path => "Explore/FindStuff", :except => [:new, :edit]
  resources :possessions, :path => "StuffIOwn", :only => [:new, :edit]
  resources :trades, :path => "Explore/"
  match "/Explore/:id/results" => "trades#results", :as => :results
  devise_for :users
  resources :users, :path => "", :only => [:index, :show]

  
  #match "/:name" => "users#show"
end
