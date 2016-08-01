Rails.application.routes.draw do

  devise_for :users, :controllers => { registrations: "registrations" }

  root to: "adventures#index"

  resources :adventures do

    get "/content", to: "adventures#content"
    get "/design", to: "adventures#design"

    resources :chapters do
      resources :choices do
        collection do
          post "/bulk", to: 'choices#bulk_create'
        end
      end
    end

  end

end
