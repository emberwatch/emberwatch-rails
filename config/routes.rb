Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  namespace :api do
    get 'books', to: 'temporary#books'
    get 'contribute', to: 'temporary#contribute'
    get 'events', to: 'temporary#events'
    get 'people', to: 'temporary#people'
    get 'podcast-feeds', to: 'temporary#podcast_feeds'
    get 'screencasts', to: 'temporary#screencasts'
    get 'talks', to: 'temporary#talks'
    get 'tutorials', to: 'temporary#tutorials'
  end
end
