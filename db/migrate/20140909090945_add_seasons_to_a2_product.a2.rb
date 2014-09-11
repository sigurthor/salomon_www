# This migration comes from a2 (originally 20140823080707)
class AddSeasonsToA2Product < ActiveRecord::Migration
  def up
    add_column :a2_products, :seasons, :text , :array => true, :default => []
    add_index :a2_products, :seasons, :using => 'gin'

    A2::Product.all.each do |p|
      p.seasons = p.product_variants.map{|v| v.season}.uniq
      p.save
    end
  end

  def down
    remove_index :a2_products, :seasons
    remove_column :a2_products, :seasons
  end
end
