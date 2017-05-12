Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    resources :books, except: %i(new edit)
    resources :events, except: %i(new edit)
    resources :people, except: %i(new edit)
    resources :screencasts, except: %i(new edit)
    resources :talks, except: %i(new edit)
    get 'contribute', to: 'temporary#contribute'
    get 'podcast-feeds', to: 'temporary#podcast_feeds'
    get 'tutorials', to: 'temporary#tutorials'
  end
end
