require('pry-byebug')
require_relative('merchant')
require_relative('tag')
require_relative('transaction')



groceries = Tag.new({
  'category' => 'groceries'
  })

treats = Tag.new({
  'category' => 'treats'
  })

  binding.pry

  nil
