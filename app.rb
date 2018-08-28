require('sinatra')
require('sinatra/contrib/all')
require_relative('controllers/merchants_controller')
require_relative('controllers/tags_controller')
require_relative('controllers/transactions_controller')
require_relative('controllers/budgets_controller')
also_reload('./models/*')

get '/' do
  @budgets = Budget.all
  erb(:index)
end
