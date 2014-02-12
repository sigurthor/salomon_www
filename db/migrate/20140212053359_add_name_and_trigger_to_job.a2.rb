# This migration comes from a2 (originally 20140212053317)
class AddNameAndTriggerToJob < ActiveRecord::Migration
  def change
    add_column :a2_jobs, :name, :string
    add_column :a2_jobs, :trigger, :string
  end
end
