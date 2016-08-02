Rails.application.routes.draw do

  devise_for :users, :controllers => { registrations: "registrations" }

  root to: "adventures#index"

  resources :adventures do

    get "/content", to: "adventures#content"
    get "/design", to: "adventures#design"

    resources :chapters do
      post "/destroy_children_chapters", to: "chapters#bulk_destroy"
      resources :choices
    end

  end

end
