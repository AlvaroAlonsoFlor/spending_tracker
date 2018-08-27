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
    @transaction_date = info['transaction_date']

  end

  def save
    sql = "INSERT INTO transactions
    (description, merchant_id, tag_id, amount)
    VALUES
    ($1, $2, $3, $4, $5)
    RETURNING id
    "
    values =[@description, @merchant_id, @tag_id, @amount, @transaction_date]
    results = SqlRunner.run(sql, values)
    @id = results[0]['id'].to_i
  end

  def update
    sql = "UPDATE transactions
    SET
    description = $1, merchant_id = $2, tag_id = $3, amount = $4, transaction_date = $6
    WHERE id = $5
    "
    values = [@description, @merchant_id, @tag_id, @amount, @id, @transaction_date]
    results = SqlRunner.run(sql, values)
  end

  def merchant
    sql = "SELECT * FROM merchants
    WHERE id = $1"
    values = [@merchant_id]
    result = SqlRunner.run(sql,values)
    Merchant.new(result[0])
  end

  def tag
    sql = "SELECT * FROM tags
    WHERE id = $1"
    values = [@tag_id]
    result = SqlRunner.run(sql,values)
    Tag.new(result[0])
  end

  def self.map_items(items)
    items.map { |item| Transaction.new(item)  }
  end

  def self.all
    sql = "SELECT * FROM transactions"
    results = SqlRunner.run(sql)
    map_items(results)
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM transactions
    WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)[0]
    Transaction.new(result)
  end

  def self.delete_by_id(id)
    sql = "DELETE FROM transactions
    WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
  end

  #TOTAL_AMOUNT

  # I might refactor passing an array of objects in the future, for now without parameters seems to be more efficent and easy to use. More in the specs.

  def self.total_amount
    transactions = self.all
    amounts = transactions.map { |transaction| transaction.amount }
    amounts.reduce(:+)
  end


end
