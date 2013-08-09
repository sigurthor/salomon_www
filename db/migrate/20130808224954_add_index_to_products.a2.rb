# This migration comes from a2 (originally 20130620141228)
class AddIndexToProducts < ActiveRecord::Migration
  def change
    add_index :a2_products, :article_code, :unique => true
  end
end
