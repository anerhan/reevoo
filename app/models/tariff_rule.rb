class TariffRule < ActiveRecord::Base


  SCHEMAS = [:every_free, :for_all] #0=>every_free,1=> for_all

  has_many :products


  validates :name, :presence => true
  validates :discount, :presence => true, :numericality => true, :inclusion => {:in => 0..10000}
  validates :quantity, :schema, :presence => true, :numericality => {:only_integer => true}
  validates :schema, :numericality => true, :inclusion => {:in => 0..(SCHEMAS.size - 1)}


  # Returns index by Schema Name
  def self.schema(rule_name)
    SCHEMAS.find_index(:"#{rule_name}")
  end

  #Apply discount for ProductsLists Object
  def apply(products)
    rule_products = products.select { |p| p.tariff_rule_id == id }
    full_price    = rule_products.collect { |p| p.price }.sum
    @rp_count     = rule_products.size
    @dc           = 0

    if quantity == 0
      every
    elsif quantity > 0
      send(SCHEMAS[schema]) if @rp_count >= quantity
    end
    full_price - @dc
  end


  private

  def every
    @dc = @rp_count * discount
  end

  def every_free
    @dc = (@rp_count / quantity) * discount
  end

  def for_all
    @dc = quantity * discount
  end

end



