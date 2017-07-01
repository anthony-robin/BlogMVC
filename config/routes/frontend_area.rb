# Users
resources :users, only: %i[index show]

# Blogs
namespace :blogs do
  resources :tags, only: %i[show]
  resources :searches, only: %i[index]
  resources :autocompletes,
            only: %i[index],
            defaults: { format: 'json' }
end

resources :blogs, only: %i[index], concerns: :paginatable do
  resources :comments, only: %i[create destroy]
end

resources :categories, only: [] do
  resources :blogs,
    only: %i[index show],
    controller: 'categories/blogs',
    concerns: :paginatable
end

# Contacts
resources :contacts, only: %i[index new create]
