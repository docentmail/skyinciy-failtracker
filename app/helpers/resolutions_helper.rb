module ResolutionsHelper





def self.compare_stacktaces(par_st_failure, par_st_resolution)
  st_failure=par_st_failure.nil? ? nil : par_st_failure.clone
  st_resolution=par_st_resolution.nil? ? nil : par_st_resolution.clone
   if  st_failure.nil? || st_failure.strip.empty?
     puts "--exit_1"
     return 0
   end

   if  st_resolution .nil? || st_resolution.strip.empty?
     puts "--exit_2"
     return 0
   end

   if st_resolution.eql?(st_failure)
     puts "--exit_3"
     return 100
   end

 # regexp with Java lines
 # escape .
   st_resolution.gsub! /\./ ,"\\\\."
   st_resolution.gsub! /\(/ ,"\\\\("
   st_resolution.gsub! /\)/ ,"\\\\)"
   st_resolution.gsub! /\$/ ,"\\\\$"
   # replace @@@ with .*
   st_resolution.gsub! /@@@/ , ".*"
   
   #st_resolution=".*com\\..*"
   puts "st_resolution="+st_resolution

  if /#{st_resolution}/ =~ st_failure
    puts "--exit_4"
       return 100
  end

  # regexp with removed Java lines
   st_resolution.gsub! /:[\d]*/ ,""
   st_failure.gsub! /:[\d]*/ ,""

      puts "st_resolution="+st_resolution
   puts "st_failure="+st_failure

  if /#{st_resolution}/ =~ st_failure
    puts "--exit_5"
    return 80
  end

  puts "--exit_last"
  return 0

 end

#  @return  
# 100 for regexp equity
# 0 for absolutly different - or not defined
def self.compare_err_messages(par_msg_failure, par_msg_resolution)
  msg_failure=par_msg_failure.nil? ? nil : par_msg_failure.clone
  msg_resolution=par_msg_resolution.nil? ? nil : par_msg_resolution.clone
  # puts "compare_err_messages"
  # puts " msg_failure="+ msg_failure
  # puts " msg_resolution="+ msg_resolution
   if  msg_failure.nil? || msg_failure.strip.empty?
     puts "--exit_1"
     return 0
   end

   if  msg_resolution .nil? || msg_resolution.strip.empty?
     puts "--exit_2"
     return 0
   end

   if msg_resolution.eql?(msg_failure)
     puts "--exit_3"
     return 100
   end

  # regexp with Java lines
   # escape .
   msg_resolution.gsub! /\./ ,"\\\\."
   msg_resolution.gsub! /\(/ ,"\\\\("
   msg_resolution.gsub! /\)/ ,"\\\\)"
   msg_resolution.gsub! /\$/ ,"\\\\$"
   # replace @@@ with .*
   msg_resolution.gsub! /@@@/ , ".*"

   #st_resolution=".*com\\..*"
   puts "st_resolution="+msg_resolution

  if /#{msg_resolution}/ =~ msg_failure
    puts "--exit_4"
    return 100
  end

  puts "--exit_last"
  return 0

end

#  @return  
# 100 for rabsolute quity
# 0 for absolutly different - or not defined
def self.compare_test(par_test_failure, par_test_resolution)
  test_failure=par_test_failure.nil? ? nil : par_test_failure.clone
  test_resolution=par_test_resolution.nil? ? nil : par_test_resolution.clone
   if  test_failure.nil? || test_failure.strip.empty?
     puts "--exit_1"
     return 0
   end

   if  test_resolution.nil? || test_resolution.strip.empty?
     puts "--exit_2"
     return 0
   end

   if test_resolution.eql?(test_failure)
     puts "--exit_3"
     return 100
   end

   return 0

end

#  @return  
# 100 for rabsolute quity
# 0 for absolutly different - or not defined
def self.compare_applications(par_app_failure, par_app_resolution)
  app_failure=par_app_failure.nil? ? nil : par_app_failure.clone
  app_resolution=par_app_resolution.nil? ? nil : par_app_resolution.clone
   if  app_failure.nil? || app_failure.strip.empty?
     puts "--exit_1"
     return 0
   end

   if  app_resolution.nil? || app_resolution.strip.empty?
     puts "--exit_2"
     return 0
   end

   if app_failure.eql?(app_resolution)
     puts "--exit_3"
     return 100
   end

   return 0

end


# calculation:
#   stack_trace - 100%
#   msg -15%
#   test - 20%
#   app - 5%
#  @return  maximum = 100 minimum 0
def self.compare_failure_resolution(
   fl_application, fl_test, fl_exception_msg, fl_stack_trace,
   rsl_application, rsl_test, rsl_exception_msg_ptrn, rsl_stack_trace_ptrn)

   rez_proc=0
  # stack trace
  rez_proc_stack_trace = compare_stacktaces(fl_stack_trace, rsl_stack_trace_ptrn)

  # error msg
  rez_proc_msg = compare_err_messages(fl_exception_msg, rsl_exception_msg_ptrn)

  rez_proc_test =  compare_test(fl_test, rsl_test)

  rez_proc_app =   compare_applications(fl_application, rsl_application)
  puts "100%  stack_trace="+ rez_proc_stack_trace.to_s()+ ";  15% msg=" +rez_proc_msg.to_s()+ 
     ";  15% mtest="+ rez_proc_test.to_s()+ " ; 5% ap="+ rez_proc_app.to_s()

  rez_proc= rez_proc_stack_trace+rez_proc_msg*15/100+rez_proc_test*20/100+rez_proc_app*5/100
  puts "% before raunding ="+ rez_proc.to_s()

  if (rez_proc>=100 )
   return 100
  else
     return rez_proc
  end

 end

# def self.compare_failure_resolution(
#    fl_application, fl_test, fl_exception_msg, fl_stack_trace,
#    rsl_application, rsl_test, rsl_exception_msg_ptrn, rsl_stack_trace_ptrn)
# 	return Random.rand(99)
#  end


end
