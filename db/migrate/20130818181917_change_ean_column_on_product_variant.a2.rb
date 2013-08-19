# This migration comes from a2 (originally 20130818135656)
class ChangeEanColumnOnProductVariant < ActiveRecord::Migration
  def up
    change_column :a2_product_variants, :ean, :string
  end

  def down
  end
end
