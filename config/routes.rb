Rails.application.routes.draw do
  resources :users, only: [:show, :index] do
    resources :posts, only: [:index, :show]
  end
end

