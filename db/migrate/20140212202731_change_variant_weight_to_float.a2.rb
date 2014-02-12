# This migration comes from a2 (originally 20140212070036)
class ChangeVariantWeightToFloat < ActiveRecord::Migration
  def up
    change_column :a2_product_variants, :weight, :float
  end

  def down
    change_column :a2_product_variants, :weight, :int
  end
end
