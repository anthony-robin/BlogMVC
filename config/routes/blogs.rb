resources :blogs, except: %i[show edit], concerns: :paginatable do
  resources :comments, only: %i[create destroy]
end

namespace :blogs do
  resources :searches, only: %i[index]
  resources :autocompletes,
            only: %i[index],
            defaults: { format: 'json' }
end

get 'tags/:tag', to: 'blogs#index', as: :tag
