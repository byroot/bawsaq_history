BawsaqHistory::Application.routes.draw do

  resources :stocks, constraints: {id: /[A-Z]{3}/}
  root to: 'stocks#index'

end
