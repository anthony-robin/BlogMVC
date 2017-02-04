Rails.application.routes.draw do
  root 'homes#index'
  devise_for :users,
             controllers: {
               registrations: 'registrations'
             }

  concern :paginatable do
    get '(page/:page)', action: :index, on: :collection, as: ''
  end

  resources :blogs, except: [:show, :edit], concerns: :paginatable
  resources :categories, except: [:show], concerns: :paginatable

  resources :categories, only: [] do
    resources :blogs, only: [:index, :show, :edit], path: ''
  end

  resources :users, only: [:index]
end
