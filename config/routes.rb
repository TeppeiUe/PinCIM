Rails.application.routes.draw do
  devise_for :users, skip: :all
  devise_scope :user do
    get '/sign_in' => 'devise/sessions#new'
    post '/sign_in' => 'devise/sessions#create'
    delete '/sign_out' => 'devise/sessions#destroy'
  end
  root 'homes#top'
  get '/map' => 'homes#map'
  resources :visit_records do
    resources :tasks, only: [:new, :create, :show, :edit, :update, :destroy]
    resources :activity_details, only: [:create, :update, :destroy]
    collection do
      get 'get_customer', default: { format: :json }
      post 'counting'
      post 'search'
    end
  end
  get '/tasks' => 'tasks#index'
  resources :activities, only: [:create, :index, :edit, :update]
  post 'activities/search'

  namespace :customers do
    namespace :registrations do
      get 'get_customer_name', default: { format: :json }
      get 'get_key_person_name', default: { format: :json }
      get 'get_sales_end_name', default: { format: :json }
      get 'get_belong_name', default: { format: :json }
    end
  end
  resources :customers, only: [:new, :create, :index, :show, :edit, :update] do
    resources :customer_key_people, only: [:new, :create, :edit, :update, :destroy]
  end
  post 'customers/search'
  resources :key_people, only: [:create, :index, :show, :edit, :update]
  post 'key_people/search'
  resources :belongs, only: [:create, :index, :show, :edit, :update]
  post 'belongs/search'
  resources :sales_ends, only: [:create, :index, :show, :edit, :update]
  post 'sales_ends/search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
