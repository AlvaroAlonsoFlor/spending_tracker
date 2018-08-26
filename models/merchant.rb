require_relative('../db/sql_runner')

class Merchant
  attr_reader :id
  attr_accessor :name

  def initialize(info)
    @name = info['name']
    @id = info['id'].to_i if info['id']
  end

  def save
    sql = "INSERT INTO merchants
    (name)
    VALUES
    ($1)
    RETURNING id
    "
    values =[@name]
    results = SqlRunner.run(sql, values)
    @id = results[0]['id'].to_i
  end

  def update
    sql = "UPDATE merchants
    SET
    name = $2
    WHERE id = $1
    "
    values = [@id, @name]
    results = SqlRunner.run(sql, values)
  end

  def self.map_items(items)
    items.map { |item| Merchant.new(item)  }
  end

  def self.all
    sql = "SELECT * FROM merchants"
    results = SqlRunner.run(sql)
    map_items(results)
  end

  def self.find_by_id(id)
    sql = "SELECT FROM merchants
    WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)[0]
    Merchant.new(result)
  end

  def self.delete_by_id(id)
    sql = "DELETE FROM merchants
    WHERE id = $1"
    values = [id]
    SqlRunner.run(sql, values)
  end



end
