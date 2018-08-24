class Tag
  attr_reader :id
  attr_accessor :category

  def initialize(info)
    @category = info['category']
    @id = info['id'].to_i if info['id']

  end
end
