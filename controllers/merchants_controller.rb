require('sinatra')
require('sinatra/contrib/all') if development?
require('pry-byebug')
require_relative('../models/merchant')


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
  @merchant = Merchant.find_by_id(params[:id])
  # For some reason params[:id] works with '' and :
  erb(:'merchants/edit')
end

#UPDATE

put '/merchants/:id' do
  Merchant.new(params).update
  redirect '/merchants'
end

#DELETE

post '/merchants/:id/delete' do
  Merchant.delete_by_id(params[:id])
  redirect '/merchants'
end
