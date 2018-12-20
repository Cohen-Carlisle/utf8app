class Utf8Controller < ApplicationController
  def example
    render plain: 'The symbol for the foot unit of measurement is ′.'
  end

  def json_example
    render json: {feet: '′', inches: '″'}
  end
end
