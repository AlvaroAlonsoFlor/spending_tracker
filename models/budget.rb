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
end
