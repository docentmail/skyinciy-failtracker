class UpdateBuild < ActiveRecord::Migration
  def up
        change_column :builds, :application, :integer
        change_column :builds, :environment, :integer
	add_column :builds, :link_to_jenkins_build, :string
	add_column :builds, :jenkins_build_name, :string
	add_column :builds, :app_release, :integer
	add_column :builds, :bag_build, :boolean
  end

  def down
	raise ActiveRecord::IrreversibleMigration
  end
end
