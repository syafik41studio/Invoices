class PatientsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_user
  
  # GET /patients
  # GET /patients.xml
  def index
    @title = "Patients"
    @patients = Patient.where("user_id = ?", current_user.id).order(:name).page(params[:page])
    @page = params[:page] ? params[:page].to_i + 1 : 2
    respond_to do |format|
      format.html # index.html.erb
      format.js # index.html.erb
      format.xml  { render :xml => @patients }
    end
  end


  # GET /patients/1
  # GET /patients/1.xml
  def show
    @title = "View Patient"
    @patient = Patient.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @patient }
    end
  end

  # GET /patients/new
  # GET /patients/new.xml
  def new
    @title = "Add New"
    @patient = Patient.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @patient }
    end
  end

  # GET /patients/1/edit
  def edit
    @title = "Edit"
    @patient = Patient.find(params[:id])
  end

  # POST /patients
  # POST /patients.xml
  def create
    @patient = Patient.new(params[:patient].merge(:user_id => current_user.id))

    respond_to do |format|
      if @patient.save
        format.html { redirect_to(@patient, :notice => 'Patient was successfully created.') }
        format.xml  { render :xml => @patient, :status => :created, :location => @patient }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @patient.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /patients/1
  # PUT /patients/1.xml
  def update
    @patient = Patient.find(params[:id])

    respond_to do |format|
      if @patient.update_attributes(params[:patient])
        format.html { redirect_to(@patient, :notice => 'Patient was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @patient.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /patients/1
  # DELETE /patients/1.xml
  def destroy
    @patient = Patient.find(params[:id])
    @patient.destroy

    respond_to do |format|
      format.html { redirect_to(patients_url) }
      format.xml  { head :ok }
    end
  end

  private

  def get_user
    @user = User.find(params[:user_id])
  end
  
end
