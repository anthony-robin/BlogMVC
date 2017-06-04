namespace :admin do
  root 'dashboards#show'

  resource :dashboard, only: %i[show]
  resources :blogs, except: %i[show]
  resources :categories, except: %i[show], concerns: :paginatable
end
