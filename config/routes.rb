Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    resources :books, except: %i(new edit)
    resources :events, except: %i(new edit)
    get 'contribute', to: 'temporary#contribute'
    get 'people', to: 'temporary#people'
    get 'podcast-feeds', to: 'temporary#podcast_feeds'
    get 'screencasts', to: 'temporary#screencasts'
    get 'talks', to: 'temporary#talks'
    get 'tutorials', to: 'temporary#tutorials'
  end
end
