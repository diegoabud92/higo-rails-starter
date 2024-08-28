Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root to: 'invoices#index', as: :authenticated_root
  end

  unauthenticated do
    root to: 'devise/sessions#new', as: :unauthenticated_root
  end

  %w[about].each do |page|
    get page, to: 'pages#show'
  end

  resources :invoices do
    collection do
      get 'upload_invoices', to: 'invoices#new_upload', as: 'new_upload_invoices'
      post 'upload_invoices', to: 'invoices#upload', as: 'upload_invoices'
      get 'provider_invoices/:provider_name', to: 'invoices#provider_invoices', as: 'provider_invoices'
    end
  end

  resources :providers, only: [:new, :create, :show, :index]

  # Uncomment to use React
  # root to: 'react_app#index'
  # get '*path', to: 'react_app#index'
end
