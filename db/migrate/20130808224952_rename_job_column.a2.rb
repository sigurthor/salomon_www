# This migration comes from a2 (originally 20130620095137)
class RenameJobColumn < ActiveRecord::Migration
  def up
    rename_column :a2_jobs, :job_type, :job_type_id
    change_column :a2_jobs, :job_type_id, :integer
  end

  def down
    rename_column :a2_jobs, :job_type_id, :job_type
    change_column :a2_jobs, :job_type, :string
  end
end
