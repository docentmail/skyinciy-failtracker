# fake connector implementation - doesn't requre any build system
module MockBuildSystemConnectorHelper

	def self.get_recentbuilds_list_ext(par_buildname)
	    recentbuilds = Array.new
	    recentbuilds << {"name" => par_buildname , "date" => "2012-04-26_04-43-29"}
	    recentbuilds << {"name" => par_buildname , "date" => "2012-04-26_15-23-28"}
	    return recentbuilds
	end

	def self.set_loaded_for_recentbulds_list_ext(par_recentbuilds)
	 	for recentbuild in par_recentbuilds
	 		recentbuild["loaded"]=false
	 	end   
	 	return par_recentbuilds
	end

	def self.get_recentbuild_self( buildname, builddate )
		# some logic to get data from build system
		application = 1  # $appls = {"SPIN" => 1, "SELLPO" => 2 }                                                                                  
		environment =2 #$environments = {"TRUNK" => 1, "TEST" => 2, "PATCH" => 3, "PILOT" => 3, "PROD" => 4}
		launched_at = Time.new 
		notes =  "this some notes"
		link_to_jenkins_build = "http://qam:8080/details/SPIN_PROD/builds/2012-07-25_18-17-51"
		jenkins_build_name= "SPIN_PROD"
		app_release= 10 #$releases = {"2012_06_20_R" => 10, "2012_07_18_R" => 20, "2012_08_15_R" => 30}
		bag_build =false

		build = Build.new
	
		build.application = application
		build.environment = environment
		build.launched_at = launched_at
		build.notes = notes
		build.link_to_jenkins_build = link_to_jenkins_build
		build.jenkins_build_name = jenkins_build_name
		build.app_release = app_release
		build.bag_build = bag_build

		return build

	end	

	def self.get_recentbuild_failures_self( buildname, builddate )


	  exception_msg ="Error description: ERROR: Element //div[@id='cntr_menu_int']//li[.//a/descendant-or-self::*[contains(text(),'Item Mgmt')]]//li[.//a/descendant-or-self::*[contains(text(),'Search/Browse')]]/div/a[contains(text(),'Advanced Search')] not found"
	  is_user_visible =true
	  notes = "some notes"
	  ptfnd_url = "http://qam:8080/details/spin.qa.auto.trunk_test/builds/2012-08-07_00-05-19/PthFndr/DownloadAndUploadGenericTemplateTest.testGenericTemplate005UploadVariationItems.001711488/ByStory.html"
	  stack_trace = 
"com.thoughtworks.selenium.SeleniumException: ERROR: Element //div[@id='cntr_menu_int']//li[.//a/descendant-or-self::*[contains(text(),'Item Mgmt')]]//li[.//a/descendant-or-self::*[contains(text(),'Search/Browse')]]/div/a[contains(text(),'Advanced Search')] not found"+
"com.thoughtworks.selenium.HttpCommandProcessor.throwAssertionFailureExceptionOrError(HttpCommandProcessor.java:97)"+
"com.thoughtworks.selenium.HttpCommandProcessor.doCommand(HttpCommandProcessor.java:91)"+
"com.thoughtworks.selenium.DefaultSelenium.click(DefaultSelenium.java:167)"+
"com.shc.obu.mp.qaautomation.measuring.SeleniumWithTimer.click(SeleniumWithTimer.java:186)"+
"com.shc.obu.mp.qaautomation.joystick.SeleniumWithJoystick.click(SeleniumWithJoystick.java:306)"
	  test ="DownloadAndUploadGenericTemplateTest.testGenericTemplate005UploadVariationItems"

	  	failures = Array.new
		(1..5).each do |i|
			    failure = Failure.new
				failure.exception_msg = exception_msg+i.to_s()
				failure.is_user_visible =is_user_visible
				failure.notes = notes+i.to_s()
				failure.ptfnd_url = ptfnd_url+i.to_s()
				failure.stack_trace = stack_trace+i.to_s()
				failure.test = test+i.to_s()

				failures << failure
		end

		return failures

	end	


end