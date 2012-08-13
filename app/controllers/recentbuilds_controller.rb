
class RecentbuildsController < ApplicationController



  # GET /recentbuilds/showlist
  # GET /recentbuilds/showlist.json
  def showlist
    @buildname =params[:recentbuild][:name]
    
    @recentbuilds = RecentbuildsHelper.get_buiolds_list_by_name(@buildname)
    puts "@recentbuilds"
    puts @recentbuilds

    @recentbuilds = RecentbuildsHelper.set_loaded_for_recentbulds_list(@recentbuilds)
    puts "@recentbuilds"
    puts @recentbuilds
    respond_to do |format|
        format.html { render action: "showlist" }
        format.json { render json: @build.errors, status: :unprocessable_entity }
    end
  end


  # GET /recentbuilds
  # GET /recentbuilds.json
  def index
    @builds = Build.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @builds }
    end
  end

  # GET /recentbuilds/loadbuild
  # GET /recentbuilds/loadbuild.json
  def loadbuild
    @buildname =params[:name]
    @builddate =ApplicationHelper.datetime_from_request(params[:date])
    puts "@buildname" + @buildname
    puts "@builddate" +@builddate.to_s

    # add build laading logic here
    @build = RecentbuildsHelper.get_recentbuild( @buildname, @builddate )
    failures =  RecentbuildsHelper.get_recentbuild_failures( @build.jenkins_build_name, @build.launched_at )
    
    successfully_saved =false
    


      Build.transaction do
        @build.save!

        for failure in failures 
          # add failures to build 
          # has_many :failures
          failure.build = @build
          failure.save!

          successfully_saved =true
        end  
        # raise TypeError, 'Test error during transaction'
      end  
    #rescue ActiveRecord::RecordInvalid => invalid
    #end    
    respond_to do |format|
        format.html { redirect_to @build, notice: 'Build was successfully loaded.' }
        format.json { render json: @build.errors, status: :unprocessable_entity }
    end
    # TODO graceful error reporting!

  end



end
