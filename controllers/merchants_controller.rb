require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/merchant')
also_reload('../models/*')

get '/merchants' do
  erb(:'merchants/index')
end
