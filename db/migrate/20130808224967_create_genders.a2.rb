# This migration comes from a2 (originally 20130621202910)
class CreateGenders < ActiveRecord::Migration
  def change
    create_table :a2_genders do |t|
      t.string :gender
      t.string :slug

      t.timestamps
    end

    add_index :a2_genders, [:gender,:slug], :unique => true
  end
end
