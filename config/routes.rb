Rails.application.routes.draw do


  devise_for :users
  get root to: 'homes#top'
  get 'home/about'=>'homes#about',as: 'about'
  resources :books,only: [:create,:index,:show,:edit,:update,:destroy]do
    resource :favorites,only: [:create,:destroy]
  resources :book_comments,only: [:create,:destroy]
  end
  resources :users,only: [:index,:show,:edit,:update]do
    member do
      get :favorites
    end
    resource :relationships,only: [:create,:destroy]
    get "followings"=>"relationships#followings",as: "followings"
    get "followers"=>"relationships#followers",as: "followers"
  end
  get 'search'=>'searches#search',as: "search"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
