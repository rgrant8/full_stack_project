Rails.application.routes.draw do
	
  root :to => 'watchlist#index' 

  #devise_for :users
  devise_for :users, :controllers => { :sessions => "users/sessions" }
  #devise_for :users, :controllers => {:registrations => "registrations"} 

  resources :users
  resources :stock_infos
  resources :feeds
  resources :nyses
  resources :amexes
  resources :lists
  resources :stock_user_lists

	resources :lists do 
  	collection { post :import }
  end

  scope :api do
    resources :stock_infos, defaults: {format: :json} do
      get :ohlc
    end
  end

  
  #root 'feeds#index'

  #get 'query', to: 'lists#index'
  get '/lists', to: 'lists#index', id: 'lists'
  get '/lists/:id/preview', to: 'lists#preview'
  #get '*path', to: 'watchlist#index'
  #root 'watchlist#index'

end