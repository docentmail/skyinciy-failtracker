class Build < ActiveRecord::Base
  attr_accessible :application, :environment, :launched_at, :notes, :link_to_jenkins_build, :jenkins_build_name, :app_release, :bag_build
  has_many :failures
end
