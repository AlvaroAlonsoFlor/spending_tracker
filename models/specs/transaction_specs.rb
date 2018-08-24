require('minitest/autorun')
require('minitest/rg')
require_relative('../transaction')

class TestTag < MiniTest::Test
  def setup
    @transaction1 = Transaction.new({

      'description' => 'chocolate',
      'merchant_id' => 1,
      'tag_id' => 1,
      'amount' => 1
    })

    @transaction2 = Transaction.new({

      'description' => 'cinema ticket',
      'merchant_id' => 3,
      'tag_id' => 2,
      'amount' => 10
    })

  end

  def test_has_a_description
    assert_equal("chocolate", @transaction1.description )
  end

  def test_has_an_amount
    assert_equal(1, @transaction1.amount )
  end

  # NOT POSSIBLE WITHOUT INTERACTING WITH A DATABASE

  # def test_total_amount
  #   assert_equal(11, Transaction.total_amount)
  # end


end
