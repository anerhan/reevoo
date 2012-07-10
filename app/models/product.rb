class Product < ActiveRecord::Base

  belongs_to :tariff_rule

  validates :price,       :presence => true, :numericality=>true, :inclusion => {:in => 0..10000}
  validates :code, :name, :presence => true
  validate  :price_must_be_greather_than_discount, :unless => Proc.new { |p| p.tariff_rule.blank? }





  private


  def price_must_be_greather_than_discount
    errors.add(:price,:invalid) if price < tariff_rule.discount
  end



end
