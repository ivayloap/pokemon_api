namespace :pokemons do
  desc 'fetch pokemon data one time'
  task single_fetch: :environment do
    PokemonFetchService.new.call
  end

  desc "continuously fetch pokemon data from external API. \n
  Fetch intervals are configurable with POKEMON_FETCH_INTERVAL"
  task continuous_fetch: :environment do
    idle_time = ENV.fetch('POKEMON_FETCH_INTERVAL', 60).to_i
    puts "Start continuous pokemon fetching every #{idle_time} seconds"
    loop do
      PokemonFetchService.new.call
      sleep idle_time
    end
  end
end
