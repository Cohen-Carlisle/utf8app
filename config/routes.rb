Rails.application.routes.draw do
  get '/', to: 'utf8#example'
  get '/json', to: 'utf8#json_example'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
