Rails.application.routes.draw do

  resources :scoreboards

  devise_for :admins

  resources :problem_sets, only: [:new, :edit, :create, :destroy]
  resources :challenges do
    post "submit" => "challenges#submit"
    get  "submit" => "challenges#submit"
    collection do
      get '/getoutput' => 'challenges#getoutput', as: :getoutput
    end
  end
  scope module: 'challenges' do
    get "usrOutput", to: "challenges#submit"
  end
  devise_for :users
  root "home#index"

  devise_scope :user do
    authenticated :user do
      root 'home#index', as: :authenticated_root
    end
    
    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end

    get  "home/index"
    post "challenges/submit"
    get  "login",   to: "devise/sessions#new"
    post "login",   to: "devise/sessions#create"
    delete "logout",   to: "devise/sessions#destroy"
    get  "challenges/getout"

    
  end

  #root "home#index"
  resources :canvas
end
