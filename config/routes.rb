Rails.application.routes.draw do
  resources :people do
    resources :details
  end
end
