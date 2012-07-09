require 'test_helper'


#SCHEMAS = [:every_free, :for_all] #0=>every_free,1=> for_all
#
#has_many :products
#
#
#validates :name, :presence => true
#validates :discount, :presence => true, :numericality => true, :inclusion => {:in => 0..10000}
#validates :quantity, :schema, :presence => true, :numericality => true
#
## Returns index by Schema Name
#def self.schema(rule_name)
#  SCHEMAS.find_index(:"#{rule_name}")
#end

class TariffRuleTest < ActiveSupport::TestCase

  test "should have schema" do
    rule = TariffRule.new(:quantity => 5, :discount => 0)
    assert !rule.save
  end

  # Have quantity
  test "should have quantity" do
    rule = TariffRule.new(:schema => TariffRule.schema(:every_free), :discount => 0)
    assert !rule.save
  end

  # Have only Setable schemas
  test "should have only setable schemas" do
    rule = TariffRule.new(:schema => 1, :quantity => 7, :discount => 0)
    assert !rule.save
  end

  # should have numericality quantity
  test "should have numericality quantity" do
    rule = TariffRule.new(:schema => TariffRule.schema(:every_free), :quantity => 'text')
    assert !rule.save
  end

  # should have integer quantity
  test "should have integer quantity" do
    rule = TariffRule.new(:schema => TariffRule.schema(:every_free), :quantity => 7.99)
    assert !rule.save
  end


  # should have numericality discount
  test " should have numericality discount" do
    rule = TariffRule.new(:schema => TariffRule.schema(:every_free), :quantity => 7, :discount => 'text')
    assert !rule.save
  end


end
