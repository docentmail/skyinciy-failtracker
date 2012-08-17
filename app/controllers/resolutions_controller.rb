
class ResolutionsController < ApplicationController
   


  # GET /resolutions
  # GET /resolutions.json
  def index
    @resolutions = Resolution.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @resolutions }
    end
  end


  # GET /resolutions/matchlist
  # GET /resolutions/matchlist.json
  def matchlist
    @failure = Failure.find(params[:failure_id])   #failure we would like find natches
    @resolutions = Resolution.all
    resolutions_selected=Array.new

    @prcnt= Hash.new 
    @resolutions.each{|r| 
        cur_prc=    ResolutionsHelper.compare_failure_resolution(
        (@failure.build.application).nil? ? "Any" : $appls.key(@failure.build.application), @failure.test, @failure.exception_msg, @failure.stack_trace,
        (r.application).nil? ? "Any" : $appls.key(r.application) , r.test, r.exception_msg_ptrn, r.stack_trace_ptrn)
        if (cur_prc>10) 
          @prcnt.store(r.id, cur_prc)
          resolutions_selected.push(r)
        end  
    }

    resolutions_selected.sort_by! {|resolution| -@prcnt.fetch(resolution.id) }
    @resolutions=resolutions_selected

    respond_to do |format|
      format.html { render :action => "index" } # new.html.erb
      format.json { render json: @resolution }
    end
  end


  # GET /resolutions/1
  # GET /resolutions/1.json
  def show
    @resolution = Resolution.find(params[:id])
    

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @resolution }
    end
  end

  # GET /resolutions/new
  # GET /resolutions/new.json

  def new
    @failure = Failure.find(params[:failure_id])   #failure in resolution
    @resolution = Resolution.new
    @resolution.test= @failure.test
    @resolution.exception_msg_ptrn= @failure.exception_msg
    @resolution.stack_trace_ptrn= @failure.stack_trace
    @resolution.application= @failure.build.application


    respond_to do |format|
      format.html { render :action => "new" } # new.html.erb
      format.json { render json: @resolution }
    end
  end


  # GET /resolutions/1/edit
  def edit
    @resolution = Resolution.find(params[:id])
  end

  # POST /resolutions
  # POST /resolutions.json
  def create
    saveokay=false
    update_msg=""
    filid=params['failureid']  #creation failure in resolution
    # creation from failure - linkage requires
    @failure = Failure.find(filid)
    @resolution = Resolution.new(params[:resolution])

    Resolution.transaction do
	    saveokay=@resolution.save!
	    @failure.resolution_id=@resolution.id  #  linkagefailure in resolution
	    @failure.save!
	    #raise ActiveRecord::Rollback
	    update_msg='Resolution was successfully created and linked to the Failure.'
    end
    respond_to do |format|
      if saveokay
        format.html { redirect_to @resolution, notice: update_msg }
        format.json { render json: @resolution, status: :created, location: @resolution }
      else
        format.html { render action: "new" }
        format.json { render json: @resolution.errors, status: :unprocessable_entity }
      end
    end

  end	

  # PUT /resolutions/1
  # PUT /resolutions/1.json
  def update
    @resolution = Resolution.find(params[:id])

    respond_to do |format|
      if @resolution.update_attributes(params[:resolution])
        format.html { redirect_to @resolution, notice: 'Resolution was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @resolution.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /resolutions/1
  # DELETE /resolutions/1.json
  def destroy
    @resolution = Resolution.find(params[:id])
    @resolution.destroy

    respond_to do |format|
      format.html { redirect_to resolutions_url }
      format.json { head :no_content }
    end
  end

  # GET /resolutions/1/fix
  def fix
    @resolution = Resolution.find(params[:id])
    session[:resolution_id] = @resolution.id # store resolution in session
	
    respond_to do |format|
        format.html { redirect_to @resolution, notice: 'Resolution was successfully memorized.' }
        format.json { head :no_content }
    end

  end
                                                  
  # GET /resolution/1/clean
  def clean
    @resolution = Resolution.find(params[:id])
    session[:resolution_id] = nil  # remove resolution from session
	
    respond_to do |format|
        format.html { redirect_to @resolution, notice: 'Resolution was successfully dememorized.' }
        format.json { head :no_content }
    end

  end



  # GET /resolution/1/linkto
  def linkto
    failure_id=session[:failure_id] 
    @resolution = Resolution.find(params[:id])
    message=""
	
    if !failure_id.nil? 
	@failure = Failure.find(failure_id)	
	    @failure.resolution_id=@resolution.id  #  linkagefailure in resolution
	    @failure.save
	    message="Resolution was linked to memorized failure"
    else
	    message="Resolution was NOT linked. Memorize failure before."
    end

    respond_to do |format|
        format.html { redirect_to @resolution, notice: message }
        format.json { head :no_content }
    end

  end


end
