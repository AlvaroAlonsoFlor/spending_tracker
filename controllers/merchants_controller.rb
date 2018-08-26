require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/merchant')
also_reload('../models/*')

# INDEX

get '/merchants' do
  @merchants = Merchant.all
  erb(:'merchants/index')
end

# NEW

get '/merchants/new' do
  erb(:'merchants/new')
end

#CREATE

post '/merchants' do
  new_merchant = Merchant.new(params)
  new_merchant.save
  redirect '/merchants'
end

#EDIT

get '/merchants/:id/edit' do
  @merchant = Merchant.find_by_id(params['id'])
  erb(:'merchants/edit')
end

#UPDATE

#DELETE
