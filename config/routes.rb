Rails.application.routes.draw do

  root :to => "pages#home"
  match '/about',   :to => 'pages#about',    via: 'get'
  match '/contact', :to => 'pages#contact',  via: 'get'
  match '/help',    :to => 'pages#help',     via: 'get'
  match '/signup',  :to => 'users#new',      via: 'get'
  
end
