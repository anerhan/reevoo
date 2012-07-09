class CreateTariffRules < ActiveRecord::Migration
  def change
    create_table :tariff_rules do |t|
      t.string  :name                                     # Name of Rule
      t.integer :quantity,:default=>0, :null => false    # Quantity after Live Discount
      t.decimal :discount, :precision => 8, :scale => 2  # Must be < 10000
      t.integer :schema, :null => false
      t.timestamps
    end

  end
end
