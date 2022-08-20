Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'pokemon', to: 'pokemons#show'
      get 'pokemons', to: 'pokemons#index'
    end
  end
end
