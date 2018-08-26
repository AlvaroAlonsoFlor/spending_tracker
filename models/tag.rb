require_relative('../db/sql_runner')

class Tag
  attr_reader (:id)
  attr_accessor (:category)

  def initialize(info)
    @category = info['category']
    @id = info['id'].to_i if info['id']

  end

  def save
    sql = "INSERT INTO tags
    (category)
    VALUES
    ($1)
    RETURNING id
    "
    values =[@category]
    results = SqlRunner.run(sql, values)
    @id = results[0]['id'].to_i
  end

  def update
    sql = "UPDATE tags
    SET
    category = $2
    WHERE id = $1
    "
    values = [@id, @category]
    results = SqlRunner.run(sql, values)
  end

  def self.map_items(items)
    items.map { |item| Tag.new(item)  }
  end

  def self.all
    sql = "SELECT * FROM tags"
    results = SqlRunner.run(sql)
    map_items(results)
  end

  def self.find_by_id(id)
    sql = "SELECT FROM tags
    WHERE id = $1"
    values = [id]
    SqlRunner.run(sql, values)
  end

  def self.delete_by_id(id)
    sql = "DELETE FROM tags
    WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)[0]
    Tag.new(result)
  end



end
