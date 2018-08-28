require('minitest/autorun')
require('minitest/rg')
require_relative('../budget')
require_relative('../transaction')

class TestBudget < MiniTest::Test
  def setup
    data = {
      'name' => 'January',
      'amount' => 500,
      'start_date' => '2018/08/01',
      'finish_date' => '2018/08/31'
    }
    @budget1 = Budget.new(data)

    @transaction1 = Transaction.new({

      'description' => 'chocolate',
      'merchant_id' => 1,
      'tag_id' => 1,
      'amount' => 1,
      'transaction_date' => '2018/08/06'
    })

    @transaction2 = Transaction.new({

      'description' => 'cinema ticket',
      'merchant_id' => 3,
      'tag_id' => 2,
      'amount' => 10,
      'transaction_date' => '2018/08/04'
    })

  end

  def test_has_a_name
    assert_equal('January', @budget1.name )
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

  def test_spending
    transactions = [@transaction1, @transaction2]
    assert_equal(11, @budget1.spending(transactions))
  end
end
