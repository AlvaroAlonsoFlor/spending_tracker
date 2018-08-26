require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/tag')
also_reload('../models/*')
require_relative('../models/tag')

#INDEX

get '/tags' do
  @tags = Tags.all
  erb(:'tags/index')
end
