require_relative('../db/sql_runner')
require_relative('tag')
require_relative('merchant')

class Transaction
  attr_reader(:id)
  attr_accessor(:description, :merchant_id, :tag_id, :amount, :transaction_date)

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
    (description, merchant_id, tag_id, amount, transaction_date)
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

  def self.total_amount
    transactions = self.all
    amounts = transactions.map { |transaction| transaction.amount }
    amounts.reduce(:+)
  end

  def self.sort_by_date
    sql = "SELECT * FROM transactions
    ORDER BY(transaction_date) DESC"
    result = SqlRunner.run(sql)
    map_items(result)
  end

  def self.filter_by_date(year, month)

    sql = "SELECT * FROM transactions
    WHERE EXTRACT(YEAR FROM transaction_date) = $1
    AND EXTRACT(MONTH FROM transaction_date) = $2"
    values = [year, month]
    result = SqlRunner.run(sql, values)
    return if result.count == 0
    map_items(result)

  end

  def self.filter_by_tag(tag_id)
    sql = "SELECT * FROM transactions
    WHERE tag_id = $1"
    values = [tag_id]
    result = SqlRunner.run(sql, values)
    return if result.count == 0
    map_items(result)
  end

  def self.filter_by_merchant(merchant_id)
    sql = "SELECT * FROM transactions
    WHERE merchant_id = $1"
    values = [merchant_id]
    result = SqlRunner.run(sql, values)
    return if result.count == 0
    map_items(result)
  end

  def self.filter_all(params)
    sql = "SELECT * FROM transactions
    "

    tag_id = "WHERE tag_id = #{params[:tag_id]}"

    merchant_id

  end

  # Submethods for filter_all

  def year_filter_query(params)
    if  params[:year]
      "WHERE EXTRACT(YEAR FROM transaction_date) = #{params[:year]}"
    else
      return ""
    end
  end

  # We change the query depending on the result of the year query

  def month_filter_query(params)
    while year_filter_query(params)
      if params[:month]
        
      end
    end
  end

  def tag_filter_query(params)
    if params[:tag_id]
        "WHERE tag_id = #{params[:tag_id]}"
    else
      return ""
    end
  end

  def merchant_filter_query(params)
    if params[:merchant_id]
      "WHERE tag_id = #{params[:tag_id]}"
    else
      return ""
    end
  end


end
