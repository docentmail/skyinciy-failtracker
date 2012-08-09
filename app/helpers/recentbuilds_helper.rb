
# MockBuildSystemConnectorHelper is used as implementaton of external connector
module RecentbuildsHelper

	def self.get_buiolds_list_by_name(par_buildname)  #get_recentbuilds_list
	    return MockBuildSystemConnectorHelper.get_recentbuilds_list_ext(par_buildname)
	end

	def self.set_loaded_for_recentbulds_list(par_recentbuilds)
		return MockBuildSystemConnectorHelper.set_loaded_for_recentbulds_list_ext(par_recentbuilds)
	end

	def self.get_recentbuild( buildname, builddate )
		return MockBuildSystemConnectorHelper.get_recentbuild_self( buildname, builddate )
	end	


	def self.get_recentbuild_failures( buildname, builddate )
		return MockBuildSystemConnectorHelper.get_recentbuild_failures_self( buildname, builddate )
	end	


end
