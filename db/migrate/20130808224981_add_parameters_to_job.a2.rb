# This migration comes from a2 (originally 20130711180321)
class AddParametersToJob < ActiveRecord::Migration
  def change
    add_column :a2_jobs, :parameters, :string
  end
end
