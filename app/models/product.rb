class Product < ActiveRecord::Base

  belongs_to :tariff_rule

  validates :price,       :presence => true, :numericality=>true, :inclusion => {:in => 0..10000}
  validates :code, :name, :presence => true

end
