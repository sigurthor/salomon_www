# This migration comes from a2 (originally 20130620143121)
class AddTagLineToProduct < ActiveRecord::Migration
  def change
    add_column :a2_products, :tag_line, :string
  end
end
