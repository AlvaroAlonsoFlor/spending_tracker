require('minitest/autorun')
require('minitest/rg')
require_relative('../budget')

class TestBudget < MiniTest::Test
  def setup
    data = {
      'name' => 'January',
      'amount' => 500,
      'start_date' => '2018/08/01'
      'finish_date' => '2018/08/31'
    }
    @budget1 = Budget.new(data)

  end

  def test_has_a_name
    assert_equal("January", @budget1.name )
  end

  def test_has_amount
    assert_equal(500, @budget1.amount)
  end

  def test_has_start_date
    assert_equal('2018/08/01', @budget1.start_date)
  end

  def test_finish_date
    assert_equal('2018/08/31', @budget1.finish_date)
  end
end
