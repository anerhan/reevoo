class Checkout < ActiveRecord::Base
  attr_accessor :products, :total, :tariff_rules

  def initialize(tariff_rules = [])
    @tariff_rules = tariff_rules
    @products = []
    @total = 0
  end

  #Returns Current total price
  def scan(product)
    @products << product
    total
  end


  def total
    @total = 0
    total_without_rule = 0
    if @products.size > 0
      without_rule_products = @products.select { |p| p.tariff_rule_id == nil }
      total_without_rule = (without_rule_products.size > 0 ? without_rule_products.collect { |p| p.price }.sum : 0)
      @tariff_rules = tariff_rules.size > 0 ? tariff_rules : TariffRule.where("id IN (?)",@products.collect { |p| p.tariff_rule_id }.uniq)
      if @tariff_rules.size > 0
        @tariff_rules.each do |tr|
          @total += tr.apply(@products)
        end
      end
    end
    @total + total_without_rule
  end

end


#Basket: FR1, SR1, FR1, CF1
#Total price expected: £22.25
#Basket: FR1, FR1
#Total price expected: £3.11
#Basket: SR1, SR1, FR1, SR1
#Total price expected: £16.61


#co = Checkout.new(TariffRule.all);fr1 = Product.find_by_code("FR1");sr1= Product.find_by_code("SR1");cf1= Product.find_by_code("CF1");
#co.scan(fr1); co.scan(sr1);co.scan(fr1);co.scan(cf1);
#co.scan(sr1); co.scan(sr1);co.scan(fr1);co.scan(sr1);co.total
#co.total