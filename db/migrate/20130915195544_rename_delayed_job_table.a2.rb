# This migration comes from a2 (originally 20130915193902)
class RenameDelayedJobTable < ActiveRecord::Migration
  def change
    rename_table :a2_delayed_jobs, :delayed_jobs
  end
end
