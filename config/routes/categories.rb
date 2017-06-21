resources :categories, except: %i[show], concerns: :paginatable

resources :categories, only: [] do
  resources :blogs, only: %i[index show edit], path: ''
end
