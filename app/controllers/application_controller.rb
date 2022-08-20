class ApplicationController < ActionController::API
  rescue_from PokemonNotFound do |exception|
    render json: { error: exception.message }, status: exception.status_code
  end
end
