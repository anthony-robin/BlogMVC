Rails.application.routes.draw do
  root 'homes#index'

  concern :paginatable do
    get '(page/:page)', action: :index, on: :collection, as: ''
  end

  draw :frontend_area
  draw :admin_area
end
