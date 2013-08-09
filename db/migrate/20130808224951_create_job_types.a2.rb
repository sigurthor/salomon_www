# This migration comes from a2 (originally 20130620095044)
class CreateJobTypes < ActiveRecord::Migration
  def change
    create_table :a2_job_types do |t|
      t.string :name
      t.string :parameters
      t.string :class_name
      t.string :method_name
      t.boolean :notify_by_email

      t.timestamps
    end
  end
end
