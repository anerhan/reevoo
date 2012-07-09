class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.references :tariff_rule                         # Reference to tariff_rule
      t.string     :code, :null => false                # Code of Product
      t.string     :name, :null => false                # Name of Product
      t.decimal    :price, :precision => 8, :scale => 2 # Must be < 10000
      t.timestamps
    end
    add_index :products, :tariff_rule_id

  end
end
