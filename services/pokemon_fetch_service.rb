class PokemonFetchService
  def call
    cleanup_database!
    fetch_types!
    fetch_pokemons!
    fill_additional_pokemon_data!
  end

  private

  def fetch_types!
    results = rest_call(:get, type_endpoint)
    results = results[:results]

    expected_count = results.count
    before_count = Type.count
    Type.insert_all(results)
    after_count = Type.count

    Rails.logger.info("[INFO] #{after_count - before_count} types were imported out of #{expected_count}")
  end

  def fetch_pokemons!
    results = rest_call(:get, pokemon_endpoint)
    results = results[:results]

    expected_count = results.count
    before_count = Pokemon.count

    Pokemon.insert_all(results)
    after_count = Pokemon.count

    Rails.logger.info("[INFO] #{after_count - before_count} pokemons were imported out of #{expected_count}")
  end

  def fill_additional_pokemon_data!
    slots_array = []

    Pokemon.all.each do |pokemon|
      data = rest_call(:get, pokemon.url)
      pokemon.update(weight: data[:weight].to_s,
                     height: data[:height].to_s,
                     external_id: data[:id].to_s)

      relate_products_and_types(pokemon, data, slots_array)
    end

    Slot.insert_all(slots_array)
    Rails.logger.info("[INFO] #{slots_array.count} relations were created")
  end

  def relate_products_and_types(pokemon, data, slots_array)
    data[:types].each do |type|
      local_type = local_types.select { |t| t[:name] == type.dig(:type, :name) }&.first
      slots_array << { external_id: type[:slot], type_id: local_type.id, pokemon_id: pokemon.id }
    end
  end

  def local_types
    @local_types ||= Type.all
  end

  def cleanup_database!
    Pokemon.delete_all
    Type.delete_all
    Slot.delete_all
  end

  def type_endpoint
    ENV.fetch('TYPE_ENDPOINT_URL')
  end

  def pokemon_endpoint
    ENV.fetch('POKEMON_ENDPOINT_URL')
  end

  def format_response(response)
    HashWithIndifferentAccess.new(JSON.parse(response.body))
  end

  def rest_call(method, url)
    connection = Faraday::Connection.new url
    result = if method == :get
               connection.get
             else
               raise "Method #{method} is not implemented."
             end
    format_response(result)
  end
end
