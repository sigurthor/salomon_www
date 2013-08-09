# This migration comes from a2 (originally 20130622123123)
class AddSlugToProduct < ActiveRecord::Migration
  def change
    add_column :a2_products, :slug, :string
    add_index :a2_products, :slug, :unique => true
    A2::Product.find_each(&:save)
  end



end
