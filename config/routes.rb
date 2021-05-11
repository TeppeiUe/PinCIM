Rails.application.routes.draw do
  root 'homes#top'
  resources :visit_records do
    resources :tasks, only: [:new, :create, :show, :edit, :update]
  end
  post 'visit_records/search'
  get '/tasks' => 'tasks#index'
  resources :activities, only: [:create, :index, :edit, :update]
  post 'activities/search'
  resources :customers, only: [:new, :create, :index, :show, :edit, :update]
  post 'customers/search'
  resources :key_people, only: [:create, :index, :show, :edit, :update]
  post 'key_people/search'
  resources :belongs, only: [:create, :index, :show, :edit, :update]
  post 'belongs/search'
  resources :sales_ends, only: [:create, :index, :show, :edit, :update]
  post 'sales_ends/search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
