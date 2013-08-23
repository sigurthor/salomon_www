# This migration comes from a2 (originally 20130822231950)
class CreateA2AccessTokens < ActiveRecord::Migration
  def change
    create_table :a2_access_tokens do |t|
      t.string :provider
      t.string :token

      t.timestamps
    end

    add_index :a2_access_tokens, :provider, :unique => true
  end
end
