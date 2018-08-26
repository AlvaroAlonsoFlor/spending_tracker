require('sinatra')
require('sinatra/contrib/all')
require('controllers/merchants_controller')
require('controllers/tags_controller')
require('controllers/transactions_controller')

get '/' do
  erb(:index)
end
