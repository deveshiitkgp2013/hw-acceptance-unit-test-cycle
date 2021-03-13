Rottenpotatoes::Application.routes.draw do
  resources :movies
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
  get '/movies/:id/search_same_director_movies', to: 'movies#search_same_director_movies',as: 'search_same_director_movies'
end
