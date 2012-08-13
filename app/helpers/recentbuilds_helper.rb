
# MockBuildSystemConnectorHelper is used as implementaton of external connector
module RecentbuildsHelper

	def self.get_buiolds_list_by_name(par_buildname)  #get_recentbuilds_list
	    return SearsBuildSystemConnectorHelper.get_recentbuilds_list_ext(par_buildname)
	end

	def self.set_loaded_for_recentbulds_list(par_recentbuilds)
		for recentbuild in par_recentbuilds
			# build= Build.where("jenkins_build_name = :jenkins_build_name",
			# 	{:jenkins_build_name => "name"})

			#build= Build.where("jenkins_build_name = 'SELLPO_PROD'").first

			#+ build= Build.where("jenkins_build_name = :jenkins_build_name",
			# 	{:jenkins_build_name => "SELLPO_PROD"}).first
			
			#+ build= Build.where("jenkins_build_name = :jenkins_build_name",
			# 	{:jenkins_build_name => recentbuild["name"], :launched_at => recentbuild["date"]}).first

			# build= Build.where("jenkins_build_name = :jenkins_build_name AND launched_at = :launched_at",
			#  	{:jenkins_build_name => recentbuild["name"], :launched_at => recentbuild["date"]}).first

			# build= Build.where("launched_at =  '2012-05-16 18:41:29.000000'",
			#  	{:jenkins_build_name => recentbuild["name"], :launched_at => recentbuild["date"]}).first

			build= Build.where("jenkins_build_name = :jenkins_build_name AND launched_at = :launched_at",
			 	{:jenkins_build_name => recentbuild["name"], :launched_at => recentbuild["date"].strftime('%Y-%m-%d %H:%M:%S.%6N')}).first

			puts recentbuild["date"].strftime('%Y-%m-%d_%H-%M-%S.%5N')
			puts "build=", build.nil?, build.to_s
			#puts build.jenkins_build_name
			#puts build.launched_at
			#		build.launched_at = launched_at
			if build.nil? 
				recentbuild["loaded"]=false
			else
				recentbuild["loaded"]=true
			end	
	 		#recentbuild["name"]
	 	end   
	 	return par_recentbuilds
		
	end

	def self.get_recentbuild( buildname, builddate )
		return SearsBuildSystemConnectorHelper.get_recentbuild_self( buildname, builddate )
	end	


	def self.get_recentbuild_failures( buildname, builddate )
		return SearsBuildSystemConnectorHelper.get_recentbuild_failures_self( buildname, builddate )
	end	

end
