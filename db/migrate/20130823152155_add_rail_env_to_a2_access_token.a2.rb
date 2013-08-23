# This migration comes from a2 (originally 20130823152107)
class AddRailEnvToA2AccessToken < ActiveRecord::Migration
  def change
    add_column :a2_access_tokens, :rails_env, :string
    remove_index :a2_access_tokens, :provider
    add_index :a2_access_tokens, [:provider,:rails_env],:unique => true
  end
end
