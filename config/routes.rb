Rails.application.routes.draw do

  root "welcome#home"
  resources :users
  get "/signin" => "sessions#new", as: "signin"
  post "/signin" => "sessions#create"
  post "/logout" => "sessions#delete"

  post "/attractions/:id/edit" => "attractions#update", as: "attraction_edit"

  resources :attractions

end
