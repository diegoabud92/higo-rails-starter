Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root to: 'invoices#index', as: :authenticated_root
  end

  devise_scope :user do
    unauthenticated do
      root to: 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  resources :invoices do
    collection do
      get 'upload_invoices', to: 'invoices#new_upload', as: 'new_upload_invoices'
      post 'upload_invoices', to: 'invoices#upload', as: 'upload_invoices'
      get 'provider_invoices/:provider_name', to: 'invoices#provider_invoices', as: 'provider_invoices'
    end

    member do
      delete 'destroy', to: 'invoices#destroy'
    end
  end

  resources :providers
end
