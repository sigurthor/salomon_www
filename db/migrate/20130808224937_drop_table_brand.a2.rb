# This migration comes from a2 (originally 20130313205937)
class DropTableBrand < ActiveRecord::Migration
  def up
    drop_table :a2_brands
  end

end
