require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/transaction')
require_relative('../models/tag')
require_relative('../models/merchant')
also_reload('../models/*')

# INDEX

get '/transactions' do
  @transactions = Transaction.all
  erb(:'transactions/index')
end
