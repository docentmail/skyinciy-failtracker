class CreateFailures < ActiveRecord::Migration
  def change
    create_table :failures do |t|
      t.integer :build_id, :null => false
      t.integer :resolution_id
      t.string :test
      t.string :ptfnd_url
      t.text :exception_msg
      t.text :stack_trace
      t.boolean :is_user_visible
      t.text :notes

      t.timestamps
    end
  end
end
