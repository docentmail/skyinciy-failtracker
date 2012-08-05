class CreateBuilds < ActiveRecord::Migration
  def change
    create_table :builds do |t|
      t.datetime :launched_at
      t.string :application
      t.string :environment
      t.string :jenkins_folder
      t.text :notes

      t.timestamps
    end
  end
end
