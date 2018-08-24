require('minitest/autorun')
require('minitest/rg')
require_relative('../tag')

class TestTag < MiniTest::Test
  def setup
    data = {
      'category' => 'groceries'
    }
    @tag1 = Tag.new(data)

  end

  def test_has_a_category
    assert_equal("groceries", @tag1.category )
  end
end
