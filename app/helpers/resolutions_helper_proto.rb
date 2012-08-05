require "test/unit"

 

module Fc001


#  @return  
# 100 for stack trace with line numbers
# 80 for stacktrace witout lines number
# 0 for absolutly different
 def Fc001.compare_stacktaces(par_st_failure, par_st_resolution)
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
def Fc001.compare_err_messages(par_msg_failure, par_msg_resolution)
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
def Fc001.compare_test(par_test_failure, par_test_resolution)
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
def Fc001.compare_applications(par_app_failure, par_app_resolution)
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
def Fc001.compare_failure_resolution(
   fl_application, fl_test, fl_exception_msg, fl_stack_trace,
   rsl_application, rsl_test, rsl_exception_msg_ptrn, rsl_stack_trace_ptrn)

   rez_proc=0
  # stack trace
  rez_proc_stack_trace = Fc001.compare_stacktaces(fl_stack_trace, rsl_stack_trace_ptrn)

  # error msg
  rez_proc_msg = Fc001.compare_err_messages(fl_exception_msg, rsl_exception_msg_ptrn)

  rez_proc_test =  Fc001.compare_test(fl_test, rsl_test)

  rez_proc_app =   Fc001.compare_applications(fl_application, rsl_application)
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

end
=begin

=end




class TestResolution < Test::Unit::TestCase
#####################     test stackTrace     #########################################################

$originalStack = 'com.thoughtworks.selenium.HttpCommandProcessor.throwAssertionFailureExceptionOrError(HttpCommandProcessor.java:97) com.thoughtworks.selenium.HttpCommandProcessor.doCommand(HttpCommandProcessor.java:91) com.thoughtworks.selenium.DefaultSelenium.waitForPageToLoad(DefaultSelenium.java:653) com.shc.obu.mp.qaautomation.measuring.SeleniumWithTimer.waitForPageToLoad(SeleniumWithTimer.java:700) com.shc.obu.mp.qaautomation.joystick.SeleniumWithJoystick.waitForPageToLoad(SeleniumWithJoystick.java:811) com.skyincity.qaa.pathfinder.SeleniumWithTracking.waitForPageToLoad(SeleniumWithTracking.java:808) com.shc.obu.mp.sellpo.atest.AdminSmoke.testAdminSmoke004LoginSpoof(AdminSmoke.java:397) sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method) sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:57) sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43) java.lang.reflect.Method.invoke(Method.java:601) org.testng.internal.MethodHelper.invokeMethod(MethodHelper.java:641) org.testng.internal.Invoker.invokeMethod(Invoker.java:667) org.testng.internal.Invoker.invokeTestMethod(Invoker.java:840) org.testng.internal.Invoker.invokeTestMethods(Invoker.java:1141) org.testng.internal.TestMethodWorker.invokeTestMethods(TestMethodWorker.java:137) org.testng.internal.TestMethodWorker.run(TestMethodWorker.java:121) org.testng.TestRunner.runWorkers(TestRunner.java:1108) org.testng.TestRunner.privateRun(TestRunner.java:737) org.testng.TestRunner.run(TestRunner.java:596) org.testng.SuiteRunner.runTest(SuiteRunner.java:315) org.testng.SuiteRunner.access$000(SuiteRunner.java:33) org.testng.SuiteRunner$SuiteWorker.run(SuiteRunner.java:349) org.testng.internal.thread.ThreadUtil$CountDownLatchedRunnable.run(ThreadUtil.java:147) java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1110) java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:603) java.lang.Thread.run(Thread.java:722)'
$removedFirstLastEntries = '@@@com.thoughtworks.selenium.HttpCommandProcessor.doCommand(HttpCommandProcessor.java:91) com.thoughtworks.selenium.DefaultSelenium.waitForPageToLoad(DefaultSelenium.java:653) com.shc.obu.mp.qaautomation.measuring.SeleniumWithTimer.waitForPageToLoad(SeleniumWithTimer.java:700) com.shc.obu.mp.qaautomation.joystick.SeleniumWithJoystick.waitForPageToLoad(SeleniumWithJoystick.java:811) com.skyincity.qaa.pathfinder.SeleniumWithTracking.waitForPageToLoad(SeleniumWithTracking.java:808) com.shc.obu.mp.sellpo.atest.AdminSmoke.testAdminSmoke004LoginSpoof(AdminSmoke.java:397) sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method) sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:57) sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43) java.lang.reflect.Method.invoke(Method.java:601) org.testng.internal.MethodHelper.invokeMethod(MethodHelper.java:641) org.testng.internal.Invoker.invokeMethod(Invoker.java:667) org.testng.internal.Invoker.invokeTestMethod(Invoker.java:840) org.testng.internal.Invoker.invokeTestMethods(Invoker.java:1141) org.testng.internal.TestMethodWorker.invokeTestMethods(TestMethodWorker.java:137) org.testng.internal.TestMethodWorker.run(TestMethodWorker.java:121) org.testng.TestRunner.runWorkers(TestRunner.java:1108) org.testng.TestRunner.privateRun(TestRunner.java:737) org.testng.TestRunner.run(TestRunner.java:596) org.testng.SuiteRunner.runTest(SuiteRunner.java:315) org.testng.SuiteRunner.access$000(SuiteRunner.java:33) org.testng.SuiteRunner$SuiteWorker.run(SuiteRunner.java:349) org.testng.internal.thread.ThreadUtil$CountDownLatchedRunnable.run(ThreadUtil.java:147) java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1110) java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:603)@@@'
$removedFirstLastEntriesAndIntheMiddle = '@@@com.thoughtworks.selenium.HttpCommandProcessor.doCommand(HttpCommandProcessor.java:91)@@@com.shc.obu.mp.qaautomation.measuring.SeleniumWithTimer.waitForPageToLoad(SeleniumWithTimer.java:700) com.shc.obu.mp.qaautomation.joystick.SeleniumWithJoystick.waitForPageToLoad(SeleniumWithJoystick.java:811) com.skyincity.qaa.pathfinder.SeleniumWithTracking.waitForPageToLoad(SeleniumWithTracking.java:808) com.shc.obu.mp.sellpo.atest.AdminSmoke.testAdminSmoke004LoginSpoof(AdminSmoke.java:397) sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method) sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:57) sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43) java.lang.reflect.Method.invoke(Method.java:601) org.testng.internal.MethodHelper.invokeMethod(MethodHelper.java:641) org.testng.internal.Invoker.invokeMethod(Invoker.java:667) org.testng.internal.Invoker.invokeTestMethod(Invoker.java:840) org.testng.internal.Invoker.invokeTestMethods(Invoker.java:1141) org.testng.internal.TestMethodWorker.invokeTestMethods(TestMethodWorker.java:137) org.testng.internal.TestMethodWorker.run(TestMethodWorker.java:121) org.testng.TestRunner.runWorkers(TestRunner.java:1108) org.testng.TestRunner.privateRun(TestRunner.java:737) org.testng.TestRunner.run(TestRunner.java:596) org.testng.SuiteRunner.runTest(SuiteRunner.java:315) org.testng.SuiteRunner.access$000(SuiteRunner.java:33) org.testng.SuiteRunner$SuiteWorker.run(SuiteRunner.java:349) org.testng.internal.thread.ThreadUtil$CountDownLatchedRunnable.run(ThreadUtil.java:147) java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1110) java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:603)@@@'
$removedFirstLastEntriesAndIntheMiddleAndChangeLines = '@@@com.thoughtworks.selenium.HttpCommandProcessor.doCommand(HttpCommandProcessor.java:92)@@@com.shc.obu.mp.qaautomation.measuring.SeleniumWithTimer.waitForPageToLoad(SeleniumWithTimer.java:700) com.shc.obu.mp.qaautomation.joystick.SeleniumWithJoystick.waitForPageToLoad(SeleniumWithJoystick.java:811) com.skyincity.qaa.pathfinder.SeleniumWithTracking.waitForPageToLoad(SeleniumWithTracking.java:808) com.shc.obu.mp.sellpo.atest.AdminSmoke.testAdminSmoke004LoginSpoof(AdminSmoke.java:397) sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method) sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:57) sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43) java.lang.reflect.Method.invoke(Method.java:601) org.testng.internal.MethodHelper.invokeMethod(MethodHelper.java:641) org.testng.internal.Invoker.invokeMethod(Invoker.java:667) org.testng.internal.Invoker.invokeTestMethod(Invoker.java:840) org.testng.internal.Invoker.invokeTestMethods(Invoker.java:1141) org.testng.internal.TestMethodWorker.invokeTestMethods(TestMethodWorker.java:137) org.testng.internal.TestMethodWorker.run(TestMethodWorker.java:121) org.testng.TestRunner.runWorkers(TestRunner.java:1108) org.testng.TestRunner.privateRun(TestRunner.java:737) org.testng.TestRunner.run(TestRunner.java:596) org.testng.SuiteRunner.runTest(SuiteRunner.java:315) org.testng.SuiteRunner.access$000(SuiteRunner.java:33) org.testng.SuiteRunner$SuiteWorker.run(SuiteRunner.java:349) org.testng.internal.thread.ThreadUtil$CountDownLatchedRunnable.run(ThreadUtil.java:147) java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1110) java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:603)@@@'
$removedFirstLastEntriesAndIntheMiddleAndChangeLinesAdnChangeClasses  ='@@@com.thoughtworks111.selenium.HttpCommandProcessor.doCommand(HttpCommandProcessor.java:92)@@@com.shc.obu.mp.qaautomation.measuring.SeleniumWithTimer.waitForPageToLoad(SeleniumWithTimer.java:700) com.shc.obu.mp.qaautomation.joystick.SeleniumWithJoystick.waitForPageToLoad(SeleniumWithJoystick.java:811) com.skyincity.qaa.pathfinder.SeleniumWithTracking.waitForPageToLoad(SeleniumWithTracking.java:808) com.shc.obu.mp.sellpo.atest.AdminSmoke.testAdminSmoke004LoginSpoof(AdminSmoke.java:397) sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method) sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:57) sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43) java.lang.reflect.Method.invoke(Method.java:601) org.testng.internal.MethodHelper.invokeMethod(MethodHelper.java:641) org.testng.internal.Invoker.invokeMethod(Invoker.java:667) org.testng.internal.Invoker.invokeTestMethod(Invoker.java:840) org.testng.internal.Invoker.invokeTestMethods(Invoker.java:1141) org.testng.internal.TestMethodWorker.invokeTestMethods(TestMethodWorker.java:137) org.testng.internal.TestMethodWorker.run(TestMethodWorker.java:121) org.testng.TestRunner.runWorkers(TestRunner.java:1108) org.testng.TestRunner.privateRun(TestRunner.java:737) org.testng.TestRunner.run(TestRunner.java:596) org.testng.SuiteRunner.runTest(SuiteRunner.java:315) org.testng.SuiteRunner.access$000(SuiteRunner.java:33) org.testng.SuiteRunner$SuiteWorker.run(SuiteRunner.java:349) org.testng.internal.thread.ThreadUtil$CountDownLatchedRunnable.run(ThreadUtil.java:147) java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1110) java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:603)@@@'

def test_stacktaces0010
   puts "nil, nil" ,rez=Fc001.compare_stacktaces(nil, nil)
   assert_equal 0, rez
end

 def test_stacktaces0020
   puts "'', nil" ,rez=Fc001.compare_stacktaces("", nil)
   assert_equal 0, rez
end

def test_stacktaces0030
   puts "nil, ''" ,rez=Fc001.compare_stacktaces( nil, "")
   assert_equal 0, rez
end

def test_stacktaces0040
   puts "'', ''" ,rez=Fc001.compare_stacktaces( "", "")
   assert_equal 0, rez
end

 def test_stacktaces050
   puts "$originalStack, $originalStack" ,rez=Fc001.compare_stacktaces($originalStack, $originalStack)
   assert_equal 100, rez
end

def test_stacktaces055
     assert_equal  100,
       Fc001.compare_stacktaces($originalStack, $removedFirstLastEntries),
       "$originalStack, $removedFirstLastEntries"
end

 def test_stacktaces060
     assert_equal  100,
       Fc001.compare_stacktaces($originalStack, $removedFirstLastEntriesAndIntheMiddle) ,
       "$originalStack, $removedFirstLastEntriesAndIntheMiddle"
end

def test_stacktaces070
     assert_equal  80,
     Fc001.compare_stacktaces($originalStack, $removedFirstLastEntriesAndIntheMiddleAndChangeLines),
     "$originalStack, $removedFirstLastEntriesAndIntheMiddleAndChangeLines"
end

def test_stacktaces080
     puts "$originalStack, $removedFirstLastEntriesAndIntheMiddleAndChangeLinesAdnChangeClasses", rez=Fc001.compare_stacktaces($originalStack, $removedFirstLastEntriesAndIntheMiddleAndChangeLinesAdnChangeClasses)
     assert_equal  0, rez
end



####################     test message     #########################################################

$originalMsg1 = 'com.thoughtworks.selenium.SeleniumException: Timed out after 30000ms'
$RemoveNums1 = 'com.thoughtworks.selenium.SeleniumException: Timed out after @@@ms'


$originalMsg2 = 'com.thoughtworks.selenium.Wait$WaitTimedOutException: Couldn\'t find file Remittance Info.xls in download foldder !'

$RemoveFileName2 = 'com.thoughtworks.selenium.Wait$WaitTimedOutException: Couldn\'t find file @@@ in download foldder !'
$RemoveFileName_RmException2 = '@@@Couldn\'t find file @@@ in download foldder !'
$RemoveFileName_RmException_RmLast2 = '@@@Couldn\'t find file @@@ in download foldder@@@'   
$RemoveFileName_RmException_RmLast_Change1letterCase2 = '@@@Couldn\'t find File @@@ in download foldder@@@'
$RemoveFileName_RmException_RmLast_Change1letter2 = '@@@Couldn\'t find Aile @@@ in download foldder@@@'

def test_message0010
   assert_equal 0, Fc001.compare_err_messages(nil, nil) , "nil, nil"
end

 def test_message0020

   assert_equal 0, Fc001.compare_err_messages("", nil), "'', nil"
end

def test_message0030
   assert_equal 0, Fc001.compare_err_messages( nil, ""),  "nil, ''"
end

def test_message0040
   assert_equal 0, Fc001.compare_err_messages( "", ""),  "'', ''"
end

 def test_message050
   assert_equal 100, Fc001.compare_err_messages($originalMsg1, $originalMsg1),  "$originalMsg1, $originalMsg1"
end

def test_message060
     assert_equal  100, Fc001.compare_err_messages($originalMsg2, $originalMsg2),  "$originalMsg2, $originalMsg2"
end

def test_message065
    assert_equal  100,
       Fc001.compare_err_messages($originalMsg1, $RemoveNums1),
       "$originalMsg1, $RemoveNums1"
end


 def test_message070
     assert_equal  100, Fc001.compare_err_messages($originalMsg2, $RemoveFileName2), "$originalMsg2, $RemoveFileName2"
end

def test_message080
     assert_equal  100,
       Fc001.compare_err_messages($originalMsg2, $RemoveFileName_RmException2),
       "$originalMsg2, $RemoveFileName_RmException2"
end

def test_message090
     assert_equal  100,
       Fc001.compare_err_messages($originalMsg2, $RemoveFileName_RmException_RmLast2),
       "$originalMsg2, $RemoveFileName_RmException_RmLast2"
end

def test_message100
     assert_equal  0,
       Fc001.compare_err_messages($originalMsg2, $RemoveFileName_RmException_RmLast_Change1letterCase2),
       "$originalMsg2, $RemoveFileName_RmException_RmLast_Change1letterCase2"
end

def test_message110
     assert_equal  0,
       Fc001.compare_err_messages($originalMsg2, $RemoveFileName_RmException_RmLast_Change1letter2),
       "$originalMsg2, $RemoveFileName_RmException_RmLast_Change1letter2"
end

 ####################     test test       #########################################################

def test_test0010
   assert_equal 0, Fc001.compare_test(nil, nil) , "nil, nil"
end

def test_test0020
   assert_equal 0, Fc001.compare_test("", nil), "'', nil"
end

def test_test0030
   assert_equal 0, Fc001.compare_test( nil, ""),  "nil, ''"
end

def test_test0040
   assert_equal 0, Fc001.compare_test( "", ""),  "'', ''"
end

def test_test0050
   assert_equal 0, Fc001.compare_test( "FbmSmoke.testFbmSmoke007Reports", ""),  "'FbmSmoke.testFbmSmoke007Reports', ''"
end

def test_test0060
   assert_equal 100, Fc001.compare_test( "FbmSmoke.testFbmSmoke007Reports", "FbmSmoke.testFbmSmoke007Reports"),
     "'FbmSmoke.testFbmSmoke007Reports', 'FbmSmoke.testFbmSmoke007Reports'"
end

def test_test0070
   assert_equal 0, Fc001.compare_test( "FbmSmoke.testFbmSmoke007Reports11", "FbmSmoke.testFbmSmoke007Reports"),
     "'FbmSmoke.testFbmSmoke007Reports11', 'FbmSmoke.testFbmSmoke007Reports'"
end

####################     test application      #########################################################

def test_application0010
   assert_equal 0, Fc001.compare_applications(nil, nil) , "nil, nil"
end

def test_application0020
   assert_equal 0, Fc001.compare_applications("", nil), "'', nil"
end

def test_application0030
   assert_equal 0, Fc001.compare_applications( nil, ""),  "nil, ''"
end

def test_application0040
   assert_equal 0, Fc001.compare_applications( "", ""),  "'', ''"
end

def test_application0050
   assert_equal 0, Fc001.compare_applications( "SELLPO", ""),  "'SELLPO', ''"
end

def test_application0060
   assert_equal 100, Fc001.compare_applications( "SELLPO", "SELLPO"),
     "'SELLPO', 'SELLPO'"
end

def test_application0070
   assert_equal 0, Fc001.compare_applications( "SELLPO", "SPIN"),
     "'SELLPO', 'SPIN'"
end

 ####################     test full failure against resolution     #########################################################

#      $originalStack, $removedFirstLastEntriesAndIntheMiddle
#      $originalStack, $removedFirstLastEntriesAndIntheMiddleAndChangeLines

 # "$originalMsg2, $RemoveFileName_RmException_RmLast2"
 # "$originalMsg2, $RemoveFileName_RmException_RmLast_Change1letterCase2"


 def test_full010
   assert_equal 100,
     Fc001.compare_failure_resolution(
  "SELLPO", "FbmSmoke.testFbmSmoke007Reports", $originalMsg2, $originalStack,
  "", "FbmSmoke.testFbmSmoke007Reports11", $RemoveFileName_RmException_RmLast2, $removedFirstLastEntriesAndIntheMiddle)
 end

  def test_full020
    assert_equal 95,
      Fc001.compare_failure_resolution(
   "SELLPO", "FbmSmoke.testFbmSmoke007Reports", $originalMsg2, $originalStack,
   "", "FbmSmoke.testFbmSmoke007Reports11", $RemoveFileName_RmException_RmLast2, $removedFirstLastEntriesAndIntheMiddleAndChangeLines)
  end

 def test_full030
   assert_equal 100,
     Fc001.compare_failure_resolution(
  "SELLPO", "FbmSmoke.testFbmSmoke007Reports", $originalMsg2, $originalStack,
  "SELLPO", "FbmSmoke.testFbmSmoke007Reports", $RemoveFileName_RmException_RmLast2, $removedFirstLastEntriesAndIntheMiddleAndChangeLines)
 end


#  if __FILE__ == $0
#  testResolution= TestResolution.new
#  testResolution.test001


#    puts "originalStack, originalStack" ,rez=Fc001.compare_stacktace(originalStack, originalStack)
#      assert rez==100
#
#      puts "originalStack, removedFirstLastEntries", rez=Fc001.compare_stacktace(originalStack, removedFirstLastEntries)
#      assert rez==100
#
#      puts "originalStack, removedFirstLastEntriesAndIntheMiddle", rez=Fc001.compare_stacktace(originalStack, removedFirstLastEntriesAndIntheMiddle)
#      assert rez==100
#
#      puts "originalStack, removedFirstLastEntriesAndIntheMiddleAndChangeLines", rez=Fc001.compare_stacktace(originalStack, removedFirstLastEntriesAndIntheMiddleAndChangeLines)
#      assert rez==80
#
#      puts "originalStack, removedFirstLastEntriesAndIntheMiddleAndChangeLinesAdnChangeClasses", rez=Fc001.compare_stacktace(originalStack, removedFirstLastEntriesAndIntheMiddleAndChangeLinesAdnChangeClasses)
#      assert rez==0
# end
end








