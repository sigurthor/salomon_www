# This migration comes from a2 (originally 20140212202217)
class AddRunNowToA2Job < ActiveRecord::Migration
  def change
    add_column :a2_jobs, :run_now, :boolean
  end
end
