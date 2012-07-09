require 'test_helper'

class CheckoutTest < ActionDispatch::IntegrationTest
  fixtures :all

  def setup
    @checkout = Checkout.new(TariffRule.all)
  end

  def teardown
    @checkout = nil
  end


  #Basket: FR1, SR1, FR1, CF1
  #Total price expected: £22.25

  test "Checkout FR1, SR1, FR1, CF1 19.34 not 22.25" do
    @checkout.scan(products(:fr1))
    @checkout.scan(products(:sr1))
    @checkout.scan(products(:fr1))
    @checkout.scan(products(:cf1))
    assert_equal(19.34, @checkout.total)
  end

  test "Checkout  FR1, FR1 3.11" do
    @checkout.scan(products(:fr1))
    @checkout.scan(products(:fr1))
    assert_equal(3.11, @checkout.total)
  end

  test "Checkout  SR1, SR1, FR1, SR1 16.61" do
    @checkout.scan(products(:sr1))
    @checkout.scan(products(:sr1))
    @checkout.scan(products(:fr1))
    @checkout.scan(products(:sr1))
    assert_equal(16.61, @checkout.total)
  end


end
