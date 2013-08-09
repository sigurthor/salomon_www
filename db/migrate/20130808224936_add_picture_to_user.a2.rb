# This migration comes from a2 (originally 20130202001606)
class AddPictureToUser < ActiveRecord::Migration
  def change
    add_column :a2_users, :picture, :string
  end
end
