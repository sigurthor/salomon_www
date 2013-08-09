# This migration comes from a2 (originally 20130620132721)
class AddArticleCode < ActiveRecord::Migration
  def change
    add_column :a2_products, :article_code, :integer
    add_column :a2_product_color_variants, :article_code, :integer
  end
end
