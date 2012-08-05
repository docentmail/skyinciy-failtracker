class CreateResolutions < ActiveRecord::Migration
  def change
    create_table :resolutions do |t|
      t.integer :application
      t.string :test
      t.string :exception_msg_ptrn
      t.text :stack_trace_ptrn
      t.string :jira_url
      t.integer :problem_type
      t.boolean :is_resolved
      t.text :notes

      t.timestamps
    end
  end
end
