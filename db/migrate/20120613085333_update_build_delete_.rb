class UpdateBuildDelete < ActiveRecord::Migration
  def up
	remove_column :builds, :jenkins_folder
        change_column :builds, :application, :integer, :limit => nil
        change_column :builds, :environment, :integer, :limit => nil
  end

  def down
	raise ActiveRecord::IrreversibleMigration
  end
end
