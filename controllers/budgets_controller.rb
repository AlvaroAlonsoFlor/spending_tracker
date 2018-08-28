require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/transaction')
require_relative('../models/budget')
also_reload('../models/*')

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

# EDIT

# UPDATE

# DELETE
