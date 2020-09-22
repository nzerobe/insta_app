Rails.application.routes.draw do
  resources :users, only: [:index, :show, :new, :create, :edit, :update]
  resources :blogs, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    collection do
      post :confirm
    end
  end
  resources :sessions
  resources :favorites, only: [:create, :destroy, :index]
  resources :application
  # mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
