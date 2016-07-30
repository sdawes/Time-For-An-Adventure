Rails.application.routes.draw do

  devise_for :users, :controllers => { registrations: 'registrations' }

  root to: "adventures#index"

  resources :adventures do
    resources :chapters
    get '/design', to: 'adventures#design'
  end

end
