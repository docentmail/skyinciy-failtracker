module ApplicationHelper

	#global dictionaries

	$appls = {"SPIN" => 1, "SELLPO" => 2 }                                                                                  
	$releases = {"2012_06_20_R" => 10, "2012_07_18_R" => 20, "2012_08_15_R" => 30}
	$environments = {"TRUNK" => 1, "TEST" => 2, "PATCH" => 3, "PILOT" => 3, "PROD" => 4}
	$problem_type = {"Unknown problem" => 1, "Application Problem" => 2, "Automation Problem" => 3}

	# Jenkins access constnts
	# $JenkinsBuildsFolderPath ="/home/qa/jenkins/workspace/jobs";
	$JenkinsBuildsFolderPath ="C:\\My\\JRuby\\FailuresClarifier\\jobs";

	# http://qam:8080/details/spin.qa.auto.trunk_test/builds/2012-06-13_09-36-41/PthFndr/AssignMoreThanOneManfuacturerToAUserTest.testUsers005CreateAndEditManufacturer.100046823/


	###### DateTime formatinng  #####################################
	def self.datetime_for_db_search(par_datetime)
	    par_datetime.strftime('%Y-%m-%d %H:%M:%S.%6N')
	end	

	def self.datetime_to_request(par_datetime)
	  return par_datetime.strftime('%Y-%m-%d_%H-%M-%S')
	end

	def self.datetime_from_request(par_datetime_str)
		return DateTime.strptime(par_datetime_str, '%Y-%m-%d_%H-%M-%S')  
	end


	###### XML procedures  #####################################
	def self.create_doc(xml_file_content)
		require 'nokogiri'
		doc = Nokogiri::XML(xml_file_content)
		return doc
	end	

	def self.get_inner_text_for_firs(par_doc, par_xpath) 
			rez=nil
			par_doc.xpath(par_xpath).map do |add|
			  if rez.nil? 
			  	rez=add.inner_text
			  end 	
			end
			return rez
	end

	###### string converting  #####################################
	def self.string_has_value(string_content)
  			return !string_content.nil?  && !string_content.strip.empty?
	end	


	def self.get_first_n_lines_as_array(string_content, required_line_count)
		if !string_has_value(string_content) 
			return Array.new
		end
			
		strArr= string_content.split("\n")[0..required_line_count-1]
		if string_content.split("\n").length()>required_line_count 
			strArr << "..."
		end	

		return strArr

		

	end	


	def self.get_first_n_lines_as_line(string_content, required_line_count)
		strArr=get_first_n_lines_as_array(string_content, required_line_count)
		if (strArr.nil?)
			return nil
		end
			

	    strArr.each do |line|
			line = line.strip+"\n"
	    end	
		strArr.last.strip!

		return strArr.join

	end	


end
