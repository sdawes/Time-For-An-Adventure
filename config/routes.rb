Rails.application.routes.draw do

  devise_for :users, :controllers => { registrations: "registrations" }

  root to: "adventures#index"

  resources :adventures do

    get "/content", to: "adventures#content"
    get "/design", to: "adventures#design"
    get "game_destroy" => "games#delete"
    resources :chapters do
      post "/destroy_children_chapters", to: "chapters#branch_destroy"
      resources :choices
    end

  end

end
