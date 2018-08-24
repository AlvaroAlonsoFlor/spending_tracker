require_relative('../db/sql_runner')

class Transaction
  attr_reader(:id)
  attr_accessor(:description, :merchant_id, :tag_id, :amount)

  def initialize(info)
    @id = info['id'].to_i if info['id']
    @description = info['description']
    @merchant_id = info['merchant_id'].to_i
    @tag_id = info['tag_id'].to_i
    @amount = info['amount'].to_f.round(2)

  end
end
