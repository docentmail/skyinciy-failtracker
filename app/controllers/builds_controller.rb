
class BuildsController < ApplicationController
  # GET /builds
  # GET /builds.json
  def index
    @builds = Build.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @builds }
    end
  end

  # GET /builds/1
  # GET /builds/1.json
  def show
    @build = Build.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @build }
    end
  end

  # GET /builds/new
  # GET /builds/new.json
  def new
    @build = Build.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @build }
    end
  end

  # GET /builds/1/edit
  def edit
    @build = Build.find(params[:id])
  end

  # POST /builds
  # POST /builds.json
  def create
    @build = Build.new(params[:build])

    respond_to do |format|
      if @build.save
        format.html { redirect_to @build, notice: 'Build was successfully created.' }
        format.json { render json: @build, status: :created, location: @build }
      else
        format.html { render action: "new" }
        format.json { render json: @build.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /builds/1
  # PUT /builds/1.json
  def update
    @build = Build.find(params[:id])

    respond_to do |format|
      if @build.update_attributes(params[:build])
        format.html { redirect_to @build, notice: 'Build was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @build.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /builds/1
  # DELETE /builds/1.json
  def destroy
    @build = Build.find(params[:id])
    @build.destroy

    respond_to do |format|
      format.html { redirect_to builds_url }
      format.json { head :no_content }
    end
  end


  # GET /builds/1/linkresolutions
  def linkresolutions
    #puts "================================== Start linkresolutions"

    @build = Build.find(params[:id])


    # get all failures
    failures = @build.failures
    count_new_linked_failures=0

    # puts "---------------------!failures.nil?"+(!failures.nil?).to_s
    # puts "---------------------failures.length.to_s"+failures.length.to_s
    # puts "---------------------!(failures.length>0)"+(!(failures.length>0)).to_s
    
    if !failures.nil? && failures.length>0

      failures.each do |failure|  # failures loop 
        # skip allready linked to resolution
        if !failure.resolution.nil?
          # puts "------- next !failure.resolution.nil?"
          next
        end
        

        # get matched 100% resolutions
        resolutions = Resolution.all
        resolutions_selected=Array.new

        prcnt= Hash.new 
        # puts "------- start resolutions.each{|r|"
        resolutions.each{|r| 
            cur_prc=    ResolutionsHelper.compare_failure_resolution(
            (failure.build.application).nil? ? "Any" : $appls.key(failure.build.application), 
            failure.test, 
            failure.exception_msg, 
            failure.stack_trace,
            (r.application).nil? ? "Any" : $appls.key(r.application), 
            r.test, 
            r.exception_msg_ptrn, 
            r.stack_trace_ptrn)
            
            if (cur_prc==100) 
              prcnt.store(r.id, cur_prc)
              resolutions_selected.push(r)
            end  
        }
        # check that it exactly 1
        # puts "------- final resolutions_selected.length="+resolutions_selected.length.to_s
        if resolutions_selected.length==1 
          # link resolution to failure
          failure.resolution=resolutions_selected[0]
          failure.save!
          # link - add +1 in msg
          count_new_linked_failures+=1
        end  
      end # failures loop 
    end 
 
    respond_to do |format|
        format.html { redirect_to @build, notice: 'Linked '+count_new_linked_failures.to_s+' additional resolution to failure' }
        format.json { head :no_content }
    end

  end


  # GET /builds/1/fix
  def fix
    @build = Build.find(params[:id])
    session[:build_id] = @build.id # store build in session
	
    respond_to do |format|
        format.html { redirect_to @build, notice: 'Build was successfully memorized.' }
        format.json { head :no_content }
    end

  end
                                                  
  # GET /builds/1/clean
  def clean
    @build = Build.find(params[:id])
    session[:build_id] = nil  # remove build from session
	
    respond_to do |format|
        format.html { redirect_to @build, notice: 'Build was successfully dememorized.' }
        format.json { head :no_content }
    end

  end

end
