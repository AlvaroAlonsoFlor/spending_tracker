require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/transaction')
require_relative('../models/tag')
require_relative('../models/transaction')
also_reload('../models/*')

# INDEX

get '/transactions' do
  # for merchant filter
  @merchants = Merchant.all
  # for tag filter
  @tags = Tag.all
  @transactions = Transaction.sort_by_date
  erb(:'transactions/index')
end

# SHOW

get '/transactions/filter/date' do
  #call filter_by_month method
  @transactions = Transaction.filter_by_date(params[:year], params[:month])
  erb(:'transactions/filter')
end

get '/transactions/filter/tag' do
  @transactions = Transaction.filter_by_tag(params[:tag_id])
  erb(:'transactions/filter')
end

get '/transaction/filter/merchant' do
  @transactions = Transaction.filter_by_merchant(params[:merchant_id])
  erb(:'transactions/filter')
end

# NEW

get '/transactions/new' do
  @merchants = Merchant.all
  @tags = Tag.all
  erb(:'transactions/new')
end

#CREATE

post '/transactions' do
  new_transaction = Transaction.new(params)
  new_transaction.save
  redirect '/transactions'
end

#EDIT

get '/transactions/:id/edit' do
  @merchants = Merchant.all
  @tags = Tag.all
  @transaction = Transaction.find_by_id(params[:id])
  erb(:'transactions/edit')
end

# UPDATE

put '/transactions/:id' do
  Transaction.new(params).update
  redirect '/transactions'
end

#DELETE

post '/transactions/:id/delete' do
  Transaction.delete_by_id(params[:id])
  redirect '/transactions'
end
