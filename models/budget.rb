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
end
