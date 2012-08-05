# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120614082601) do

  create_table "builds", :force => true do |t|
    t.datetime "launched_at"
    t.integer  "application"
    t.integer  "environment"
    t.text     "notes"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.string   "link_to_jenkins_build"
    t.string   "jenkins_build_name"
    t.integer  "app_release"
    t.boolean  "bag_build"
  end

  create_table "failures", :force => true do |t|
    t.integer  "build_id",        :null => false
    t.integer  "resolution_id"
    t.string   "test"
    t.string   "ptfnd_url"
    t.text     "exception_msg"
    t.text     "stack_trace"
    t.boolean  "is_user_visible"
    t.text     "notes"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "resolutions", :force => true do |t|
    t.integer  "application"
    t.string   "test"
    t.string   "exception_msg_ptrn"
    t.text     "stack_trace_ptrn"
    t.string   "jira_url"
    t.integer  "problem_type"
    t.boolean  "is_resolved"
    t.text     "notes"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

end
