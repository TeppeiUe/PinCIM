Rails.application.routes.draw do
  devise_for :users, skip: :all
  devise_scope :user do
    get '/sign_in' => 'devise/sessions#new'
    post '/sign_in' => 'devise/sessions#create'
    delete '/sign_out' => 'devise/sessions#destroy'
  end

  root 'homes#top'
  get '/map' => 'homes#map'
  get '/tasks' => 'tasks#index'

  namespace :visit_records do
    namespace :registrations do
      get 'get_customer', default: { format: :json }
    end
  end

  resources :visit_records do
    resources :tasks, only: [:new, :create, :show, :edit, :update, :destroy]
    resources :activity_details, only: [:create, :update, :destroy]
    collection do
      post 'counting'
      post 'search'
    end
  end

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
    collection do
      post 'search'
    end
    resources :customer_key_people, only: [:new, :create, :edit, :update, :destroy]
  end

  resources :key_people, only: [:create, :index, :show, :edit, :update] do
    collection do
      post 'search'
    end
  end

  resources :belongs, only: [:create, :index, :show, :edit, :update] do
    collection do
      post 'search'
    end
  end

  resources :sales_ends, only: [:create, :index, :show, :edit, :update] do
    collection do
      post 'search'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
