require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/transaction')
require_relative('../models/budget')
also_reload('../models/*')

# INDEX

get '/budgets' do
  "hello"
end

# SHOW

# NEW

# CREATE

# EDIT

# UPDATE

# DELETE
