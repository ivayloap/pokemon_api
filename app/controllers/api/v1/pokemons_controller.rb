module Api
  module V1
    class PokemonsController < ApplicationController
      def index
        render json: pokemons_with_types, each_serializer: ListPokemonsSerializer
      end

      def show
        render json: pokemon_with_types, serializer: SinglePokemonSerializer
      end

      private

      def pokemon
        @pokemon ||= Pokemon.by_id_or_name(permitted_params[:id], permitted_params[:name])
      end

      def pokemon_with_types
        pokemon.includes(:types)&.first
      end

      def pokemons
        @pokemons ||= Pokemon.paginate(page: permitted_params[:page] || default_page_number,
                                       per_page: permitted_params[:per_page] || default_per_page)
      end

      def pokemons_with_types
        pokemons.includes(:types)
      end

      def permitted_params
        params.permit(:id, :name, :page, :per_page)
      end

      def default_page_number
        ENV.fetch('DEFAULT_PAGE_NUMBER', 1)
      end

      def default_per_page
        ENV.fetch('DEFAULT_PER_PAGE', 5)
      end
    end
  end
end
