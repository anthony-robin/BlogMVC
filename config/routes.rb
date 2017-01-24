Rails.application.routes.draw do
  root 'homes#index'

  concern :paginatable do
    get '(page/:page)', action: :index, on: :collection, as: ''
  end

  resources :blogs, except: [:show, :edit], concerns: :paginatable
  resources :categories, except: [:show], concerns: :paginatable do
    resources :blogs, only: [:show, :edit], path: '', concerns: :paginatable
  end
end
