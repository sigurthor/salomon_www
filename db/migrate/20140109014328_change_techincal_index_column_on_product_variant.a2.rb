# This migration comes from a2 (originally 20131205215909)
class ChangeTechincalIndexColumnOnProductVariant < ActiveRecord::Migration
  def up
    change_column :a2_product_variants, :technical_size, :string
  end

  def down
    change_column :a2_product_variants, :technical_size, :integer
  end
end
