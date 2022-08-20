class PokemonNotFound < StandardError
  attr_reader :msg

  def initialize(query_param)
    @msg = case query_param.keys
           when ['name']
             "There is no pokemon by the name '#{query_param['name']}'"
           when ['id']
             "There is no pokemon with id=#{query_param['id']}"
           end
    super
  end

  def message
    @msg
  end

  def status_code
    :not_found
  end
end
