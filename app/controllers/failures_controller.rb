
class FailuresController < ApplicationController
  # GET /failures
  # GET /failures.json
  def index
    @failures = Failure.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @failures }
    end
  end

  # GET /failures/1
  # GET /failures/1.json
  def show

    @failure = Failure.find(params[:id])


    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @failure }
    end
  end

  # GET /failures/1/fix
  def fix
    @failure = Failure.find(params[:id])
    session[:failure_id] = @failure.id # store filure in session
	
    respond_to do |format|
        format.html { redirect_to @failure, notice: 'Failure was successfully memorized.' }
        format.json { head :no_content }
    end

  end
                                                  
  # GET /failures/1/clean
  def clean
    @failure = Failure.find(params[:id])
    session[:failure_id] = nil  # remove filure from session
	
    respond_to do |format|
        format.html { redirect_to @failure, notice: 'Failure was successfully dememorized.' }
        format.json { head :no_content }
    end

  end


  # GET /failures/new
  # GET /failures/new.json
  def new
    @failure = Failure.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @failure }
    end
  end

  # GET /failures/1/edit
  def edit
    @failure = Failure.find(params[:id])
  end

  # POST /failures
  # POST /failures.json
  def create
    @failure = Failure.new(params[:failure])

    respond_to do |format|
      if @failure.save
        format.html { redirect_to @failure, notice: 'Failure was successfully created.' }
        format.json { render json: @failure, status: :created, location: @failure }
      else
        format.html { render action: "new" }
        format.json { render json: @failure.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /failures/1
  # PUT /failures/1.json
  def update
    @failure = Failure.find(params[:id])

    respond_to do |format|
      if @failure.update_attributes(params[:failure])
        format.html { redirect_to @failure, notice: 'Failure was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @failure.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /failures/1
  # DELETE /failures/1.json
  def destroy
    @failure = Failure.find(params[:id])
    @failure.destroy

    respond_to do |format|
      format.html { redirect_to failures_url }
      format.json { head :no_content }
    end
  end
end
