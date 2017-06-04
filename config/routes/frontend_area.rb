# Users
resources :users, only: %i[index show]

# Blogs
namespace :blogs do
  resources :searches, only: %i[index]
  resources :autocompletes,
            only: %i[index],
            defaults: { format: 'json' }
end

resources :blogs, only: %i[index show], concerns: :paginatable do
  resources :comments, only: %i[create destroy]
end

get 'tags/:tag', to: 'blogs#index', as: :tag

resources :categories, only: [] do
  resources :blogs, only: %i[index show edit], path: ''
end

# Contacts
resources :contacts, only: %i[index new create]
