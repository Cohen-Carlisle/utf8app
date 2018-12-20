class Utf8Controller < ApplicationController
  def example
    render plain: 'The symbol for the inch unit of measurement is ″.'
  end

  def example_json
    render json: {feet: '′', inches: '″'}
  end
end
