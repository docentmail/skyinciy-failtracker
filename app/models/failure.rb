class Failure < ActiveRecord::Base
  attr_accessible :build_id, :exception_msg, :is_user_visible, :notes, :ptfnd_url, :resolution_id, :stack_trace, :test
  belongs_to :build
  belongs_to :resolution
end
