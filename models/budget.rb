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


end
