require('sinatra')
require('sinatra/contrib/all') if development?
require_relative('../models/transaction')
require_relative('../models/budget')


# INDEX

get '/budgets' do
  @budgets = Budget.all
  erb(:'budgets/index')
end

# NEW

get '/budgets/new' do
  erb(:'budgets/new')
end

# SHOW

get '/budgets/:id' do
  @budget = Budget.find_by_id(params[:id])
  erb(:'budgets/show')
end

# CREATE

post '/budgets' do
  new_budget = Budget.new(params)
  new_budget.save
  redirect '/budgets'
end

# EDIT

get '/budgets/:id/edit' do
  @budget = Budget.find_by_id(params[:id])
  erb(:'budgets/edit')
end

# UPDATE

put '/budgets/:id' do
  Budget.new(params).update
  redirect '/budgets'
end

# DELETE

post '/budgets/:id/delete' do
  Budget.delete_by_id(params[:id])
  redirect '/budgets'
end
