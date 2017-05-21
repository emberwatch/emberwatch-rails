Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    resources :authentications, except: %i(index show new update edit destroy)
    resources :books, except: %i(new edit)
    resources :events, except: %i(new edit)
    resources :people, except: %i(new edit)
    resources :screencasts, except: %i(new edit)
    resources :talks, except: %i(new edit)
    resources :tutorials, except: %i(new edit)
    resources :users, only: %i(index show)

    namespace :podcast do
      resources :feeds, except: %i(new edit)
    end
    get 'contribute', to: 'temporary#contribute'
  end
end
