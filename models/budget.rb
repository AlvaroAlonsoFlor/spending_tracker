class Budget
  attr_reader(:id)
  attr_accessor(:name, :amount, :start_date, :finish_date )

  def initialize(info)
    @id = info['id'].to_i if info['id']
    @name = info['name']
    @amount = info['amount'].to_f.round(2)
    @start_date = info['start_date']
    @finish_date = info['finish_date']
  end

  def save
    sql = "INSERT INTO budgets
    (name, amount, start_date, finish_date)
    VALUES
    ($1, $2, $3, $4)
    RETURNING id
    "
    values =[@name, @amount, @start_date, @finish_date]
    results = SqlRunner.run(sql, values)
    @id = results[0]['id'].to_i
  end

  def update
    sql = "UPDATE budgets
    SET
    name = $1, amount = $2, start_date = $3, finish_date = $4
    WHERE id = $5
    "
    values = [@name, @amount, @start_date, @finish_date, @id]
    results = SqlRunner.run(sql, values)
  end

  def self.map_items(items)
    items.map { |item| Budget.new(item)  }
  end

  def self.all
    sql = "SELECT * FROM budgets"
    results = SqlRunner.run(sql)
    map_items(results)
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM budgets
    WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)[0]
    Budget.new(result)
  end

  def self.delete_by_id(id)
    sql = "DELETE FROM budgets
    WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
  end

  def transactions
    sql = "SELECT * FROM transactions
    WHERE transaction_date
    BETWEEN $1 AND $2
    ORDER BY transaction_date DESC"
    values = [@start_date, @finish_date]
    result = SqlRunner.run(sql, values)
    return if result.count == 0
    result.map { |transaction| Transaction.new(transaction)  }

  end


end
