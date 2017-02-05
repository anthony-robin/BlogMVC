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

# == Route Map
#
#                   Prefix Verb   URI Pattern                                 Controller#Action
#                     root GET    /                                           homes#index
#         new_user_session GET    /users/sign_in(.:format)                    devise/sessions#new
#             user_session POST   /users/sign_in(.:format)                    devise/sessions#create
#     destroy_user_session DELETE /users/sign_out(.:format)                   devise/sessions#destroy
#        new_user_password GET    /users/password/new(.:format)               devise/passwords#new
#       edit_user_password GET    /users/password/edit(.:format)              devise/passwords#edit
#            user_password PATCH  /users/password(.:format)                   devise/passwords#update
#                          PUT    /users/password(.:format)                   devise/passwords#update
#                          POST   /users/password(.:format)                   devise/passwords#create
# cancel_user_registration GET    /users/cancel(.:format)                     registrations#cancel
#    new_user_registration GET    /users/sign_up(.:format)                    registrations#new
#   edit_user_registration GET    /users/edit(.:format)                       registrations#edit
#        user_registration PATCH  /users(.:format)                            registrations#update
#                          PUT    /users(.:format)                            registrations#update
#                          DELETE /users(.:format)                            registrations#destroy
#                          POST   /users(.:format)                            registrations#create
#                    blogs GET    /blogs(/page/:page)(.:format)               blogs#index
#                          GET    /blogs(.:format)                            blogs#index
#                          POST   /blogs(.:format)                            blogs#create
#                 new_blog GET    /blogs/new(.:format)                        blogs#new
#                     blog PATCH  /blogs/:id(.:format)                        blogs#update
#                          PUT    /blogs/:id(.:format)                        blogs#update
#                          DELETE /blogs/:id(.:format)                        blogs#destroy
#               categories GET    /categories(/page/:page)(.:format)          categories#index
#                          GET    /categories(.:format)                       categories#index
#                          POST   /categories(.:format)                       categories#create
#             new_category GET    /categories/new(.:format)                   categories#new
#            edit_category GET    /categories/:id/edit(.:format)              categories#edit
#                 category PATCH  /categories/:id(.:format)                   categories#update
#                          PUT    /categories/:id(.:format)                   categories#update
#                          DELETE /categories/:id(.:format)                   categories#destroy
#           category_blogs GET    /categories/:category_id(.:format)          blogs#index
#       edit_category_blog GET    /categories/:category_id/:id/edit(.:format) blogs#edit
#            category_blog GET    /categories/:category_id/:id(.:format)      blogs#show
#                    users GET    /users(.:format)                            users#index
# 
