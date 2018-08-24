class Merchant
  attr_reader :id
  attr_accessor :name

  def initialize(info)
    @name = info['name']
    @id = info['id'].to_i if info['id']
  end

end
