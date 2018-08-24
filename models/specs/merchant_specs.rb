require('minitest/autorun')
require('minitest/rg')
require_relative('../merchant')

class TestMerchant < MiniTest::Test
  def setup
    data = {
      'name' => 'Tesco'
    }
    @merchant1 = Merchant.new(data)

  end

  def test_has_a_name
    assert_equal("Tesco", @merchant1.name )
  end
end
