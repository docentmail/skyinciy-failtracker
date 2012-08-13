# sears connector implementation
module SearsBuildSystemConnectorHelper
    

	# base HDD folder path for all builds
	#baseHddPath="/home/qa/jenkins/workspace/jobs/"
	@baseHddPath="C:/My/JRuby/FailuresClarifier/jobs/"
	
	# base WEB folder path for all Failures builds "http://qam:8080/details/spin.qa.auto.trunk_test1/builds/2012-08-11_12-45-23/PthFndr/ByStory.html
	@baseWebPathFailures="http://qam:8080/details/"


	# base WEB path to build  - http://qam:8080/jenkins/job/SELLPO_PROD/76/testNG/
	@baseWebPathBuild="http://qam:8080/jenkins/job/"


	# Template of HDD path for conrete build   ex: 	"/home/qa/jenkins/workspace/jobs/
	#buildPathTmpl="/home/qa/jenkins/workspace/jobs/"+BuildName+"/builds/"+BuildTime

	def self.get_recentbuilds_list_ext(par_buildname)
		buildFolder=@baseHddPath+par_buildname+"/builds"
		recentbuilds = Array.new		
		Dir.foreach(buildFolder) do |item|
		 	next if item == '.' or item == '..'
  			# do work on real items
  			# 2012-04-26_04-43-29
  			theDateTime=DateTime.strptime(item.to_s, '%Y-%m-%d_%H-%M-%S')
  			recentbuilds << {"name" => par_buildname , "date" => theDateTime}
		end

	    # recentbuilds = Array.new
	    # recentbuilds << {"name" => par_buildname , "date" => "2012-04-26_04-43-29"}
	    # recentbuilds << {"name" => par_buildname , "date" => "2012-04-26_15-23-28"}
	    return recentbuilds
	end

	def self.set_loaded_for_recentbulds_list_ext(par_recentbuilds)
	 	for recentbuild in par_recentbuilds
	 		recentbuild["loaded"]=false
	 	end   
	 	return par_recentbuilds
	end

	def self.get_recentbuild_self( buildname, builddate )
		buildHddPath=@baseHddPath+buildname+"/builds/"+builddate.strftime('%Y-%m-%d_%H-%M-%S')
		# get appropriate ft_build.xml
		buildFailTrackerPath=buildHddPath+"/ft_build.xml"
		puts "buildFolder"+buildFailTrackerPath

		ft_build = IO.read(buildFailTrackerPath)
		puts ft_build

		doc =ApplicationHelper.create_doc(ft_build)
		application_type=ApplicationHelper.get_inner_text_for_firs(doc, "build/application_type") 
		env=ApplicationHelper.get_inner_text_for_firs(doc, "build/environment") 
		note=ApplicationHelper.get_inner_text_for_firs(doc, "build/notes") 
		app_rel=ApplicationHelper.get_inner_text_for_firs(doc, "build/app_release") 

		puts "application_type:"+application_type
		puts "env:"+env
		puts "note:"+note
		puts "app_rel:"+app_rel

		app_release=$releases[app_rel] #$releases = {"2012_06_20_R" => 10, "2012_07_18_R" => 20, "2012_08_15_R" => 30}
		application = $appls[application_type] # $appls = {"SPIN" => 1, "SELLPO" => 2 }                                                                                  
		environment =$environments[env] #$environments = {"TRUNK" => 1, "TEST" => 2, "PATCH" => 3, "PILOT" => 3, "PROD" => 4}
		launched_at = builddate 
		notes = note 
		# # e.g. http://qam:8080/details/spin.qa.auto.trunk_test1/builds/2012-08-11_12-45-23/PthFndr/DBChangesTest.test002HazardStorage.131552856/ByStory.html
		# ptfnd_url=@baseWebPathFailures+buildname+"/builds/"+buildtime_to_folder_name(builddate)+"/PthFndr/"+item.to_s+"/ByStory.html"

		jenkins_build_name= buildname
		bag_build =false

		# parce build.xml
=begin
		        <hudson.model.StringParameterValue>
		          	<name>testToRun</name>
        		  	<description>select [testng_multy.xml] - if you would like to execute whole suite&lt;br/&gt;
						select [???????_All.xml] - if you would like to execute separate group of the tests
						select [TestName] - if you would like to execute specific test</description>
          			<value>testng_multy_prod.xml</value>
        		</hudson.model.StringParameterValue>
        		.....
			    <hudson.scm.SVNRevisionState>
			      <revisions>
			        <entry>
			          <string>http://svn.cal.intra.sears.com/repos/shc/autoQA/branches/testVerify_C/SELLPO</string>
			          <long>89198</long>
			        </entry>
			      </revisions>
			    </hudson.scm.SVNRevisionState>
			    .....
			    <number>75</number>
=end
		mavenBuildXmlPath=buildHddPath+"/build.xml"
		build_xml = IO.read(mavenBuildXmlPath)

		doc =ApplicationHelper.create_doc(build_xml)
		testNg_xml=ApplicationHelper.get_inner_text_for_firs(doc, "//hudson.model.StringParameterValue[./name[text()='testToRun']]/value") 
		branch=ApplicationHelper.get_inner_text_for_firs(doc, "//hudson.scm.SVNRevisionState/revisions/entry/string") 
		revision=ApplicationHelper.get_inner_text_for_firs(doc, "//hudson.scm.SVNRevisionState/revisions/entry/long") 
		build_number=ApplicationHelper.get_inner_text_for_firs(doc, "hudson.maven.MavenModuleSetBuild/number") 

		# prepare build record

		notes=notes+
		"\n info from Maven's build.xml"+
		"\n testNg xml="+testNg_xml+
		"\n branch="+branch+
		"\n revision="+revision+
		"\n build_number="+build_number


		# http://qam:8080/jenkins/job/SPIN_PROD/86/testNG/
		link_to_jenkins_build = @baseWebPathBuild+jenkins_build_name+'/'+build_number.to_s+'/testNG/'


		build = Build.new
	
		build.application = application
		build.environment = environment
		build.launched_at = launched_at
		build.notes = notes
		build.link_to_jenkins_build = link_to_jenkins_build
		build.jenkins_build_name = jenkins_build_name
		build.app_release = app_release
		build.bag_build = bag_build
		# TODO - build url 

		return build

	end	

	def self.buildtime_to_folder_name(par_datetime)
	  return par_datetime.strftime('%Y-%m-%d_%H-%M-%S')
	end

	def self.get_recentbuild_failures_self( buildname, builddate )
		# get list of the folders in C:\My\JRuby\FailuresClarifier\jobs\SELLPO_PROD\builds\2012-04-26_15-23-28\PthFndr\
		failuresFolder=@baseHddPath+buildname+"/builds/"+buildtime_to_folder_name(builddate)+"/PthFndr"
		
		failures = Array.new
		Dir.foreach(failuresFolder) do |item|
		 	next if item == '.' or item == '..'
  			# do work on real items
  			# AdminSmoke.testAdminSmoke004LoginSpoof.050151591

  			#load info from ft_failure.xml
  			ft_failure = IO.read(failuresFolder+"/"+item.to_s+"/ft_failure.xml")
			puts ft_failure

			doc =ApplicationHelper.create_doc(ft_failure)

			test_name=ApplicationHelper.get_inner_text_for_firs(doc, "failed_test/test_name") 
			stack_trace=ApplicationHelper.get_inner_text_for_firs(doc, "failed_test/stack_trace") 
			exception_message=ApplicationHelper.get_inner_text_for_firs(doc, "failed_test/exception_message") 
			notes=ApplicationHelper.get_inner_text_for_firs(doc, "failed_test/notes") 
			# e.g. http://qam:8080/details/spin.qa.auto.trunk_test1/builds/2012-08-11_12-45-23/PthFndr/DBChangesTest.test002HazardStorage.131552856/ByStory.html
			ptfnd_url=@baseWebPathFailures+buildname+"/builds/"+buildtime_to_folder_name(builddate)+"/PthFndr/"+item.to_s+"/ByStory.html"

			    failure = Failure.new
				failure.exception_msg =exception_message
				failure.is_user_visible =true # TODO add real value
				failure.notes = notes
				failure.ptfnd_url = ptfnd_url
				failure.stack_trace = stack_trace
				failure.test = test_name

				failures << failure
		end
		return failures

	end	


end