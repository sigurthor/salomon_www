# This migration comes from a2 (originally 20130125204143)
class UserTranslation < ActiveRecord::Migration
  def up
    A2::User.create_translation_table! :description => :string
  end

  def down
    A2::User.drop_translation_table
  end
end

