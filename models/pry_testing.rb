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

transaction1 = Transaction.new({
  'description' => "chocolate",
  'merchant_id' => 1,
  'tag_id' => 1,
  'amount' => 2.50
  })

  binding.pry

  nil
