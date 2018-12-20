class AsciiController < ApplicationController
  def example
    render plain: 'The symbol for the inch unit of measurement is ".'
  end
end
