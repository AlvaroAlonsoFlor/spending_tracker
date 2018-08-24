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

  def map_items

  end

  def self.all

  end

  def delete_by_id

  end



end
