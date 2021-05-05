Rails.application.routes.draw do
  resources :belongs, only: [:create, :index, :show, :edit, :update]
  post 'belongs/search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
