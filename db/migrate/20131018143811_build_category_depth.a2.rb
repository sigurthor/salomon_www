# This migration comes from a2 (originally 20131002222335)
class BuildCategoryDepth < ActiveRecord::Migration
  def up
    A2::ProductCategory.rebuild_depth_cache!
  end
  def down

  end
end
