require 'test_helper'

class ProductTest < ActiveSupport::TestCase
fixtures :all


#Discount must be less than product price
test "should discount can be less than product price" do
  product = Product.new(:name => 'Product 1', :price => 0.5, :tariff_rule=>tariff_rules(:buy_one_get_one_free))
  assert !product.save
end


#have code
  test "should have code" do
    product = Product.new(:name => 'Product 1', :price => 2.95)
    assert !product.save
  end

  # Have name
  test "should have name" do
    product = Product.new(:code => 'pr1', :price => 2.95)
    assert !product.save
  end

  # Have price
  test "should have price" do
    product = Product.new(:name => 'Product1', :code => 'pr1')
    assert !product.save
  end

  # prise must be numericality
  test "should have numerical price" do
    product = Product.new(:name => 'Product 1', :code => 'PR1', :price => 'text')
    assert !product.save
  end

  # Price must be less than 10000
  test "should have price included :in => 0..10000" do
    product = Product.new(:name => 'Product 1', :code => 'PR1', :price => 10001)
    assert !product.save
    product.price = 10000
    assert product.save
  end


end
