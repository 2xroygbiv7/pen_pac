Rails.application.routes.draw do
  
  match '/invoices/result/', to: 'invoices#result', as: :result_invoice, via: :get
  match '/invoices/analysis/', to: 'invoices#analysis', as: :analysis_invoice, via: :get
  
  resources :invoices
  
  # get '/invoices/result', to: "invoices#result", as: :result_invoice
  # root to: 'invoices#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
