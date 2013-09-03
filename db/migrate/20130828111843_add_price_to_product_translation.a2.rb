# This migration comes from a2 (originally 20130828101802)
class AddPriceToProductTranslation < ActiveRecord::Migration
  def change
    add_column :a2_product_translations, :price, :decimal,  :precision => 8, :scale => 2
  end
end
