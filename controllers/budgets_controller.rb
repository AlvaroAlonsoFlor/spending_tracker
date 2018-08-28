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

# SHOW

# NEW

# CREATE

# EDIT

# UPDATE

# DELETE
