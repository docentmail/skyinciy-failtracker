class Resolution < ActiveRecord::Base
  attr_accessible :application, :exception_msg_ptrn, :is_resolved, :jira_url, :notes, :problem_type, :stack_trace_ptrn, :test
  has_many :failures
end
