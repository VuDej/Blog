Rails.application.routes.draw do
  devise_for :users,
             controllers: {
                 sessions: 'users/sessions',
                 registrations: 'users/registrations'
             }
             
  root "users#index"
  resources :users, only: [:index, :show, :edit, :update] do
    resources :posts, only: [:index, :new, :show, :create, :destroy]
  end

  resources :posts do
    resources :comments, only: [:create, :destroy]
    resources :likes, only: [:create]
  end
end