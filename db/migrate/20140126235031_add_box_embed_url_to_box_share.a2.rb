# This migration comes from a2 (originally 20140126234528)
class AddBoxEmbedUrlToBoxShare < ActiveRecord::Migration
  def change
    add_column :a2_box_shares, :box_embed_url, :string
  end
end
