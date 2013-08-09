# This migration comes from a2 (originally 20130618104151)
class CreateJobs < ActiveRecord::Migration
  def change
    create_table :a2_jobs do |t|
      t.string :job_type
      t.string :job_file
      t.boolean :notifi_by_email

      t.timestamps
    end
  end
end
