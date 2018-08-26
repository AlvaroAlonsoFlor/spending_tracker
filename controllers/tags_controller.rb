require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/tag')
also_reload('../models/*')
require_relative('../models/tag')

#INDEX

get '/tags' do
  @tags = Tag.all
  erb(:'tags/index')
end

# NEW

get '/tags/new' do
  erb(:'tags/new')
end
