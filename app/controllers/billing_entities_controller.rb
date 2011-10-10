class BillingEntitiesController < ApplicationController
  # GET /billing_providers
  # GET /billing_providers.xml
  def index
    @billing_entities = if params[:active] && params[:active]=="false"
      BillingEntity.where("active IS FALSE").page(params[:page])
    else
      BillingEntity.where("active IS TRUE").page(params[:page])
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @billing_entities }
    end
  end

  # GET /billing_providers/1
  # GET /billing_providers/1.xml
  def show
    @billing_entity = BillingEntity.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @billing_entity }
    end
  end

  # GET /billing_providers/new
  # GET /billing_providers/new.xml
  def new
    @invoices = Invoice.all
    @billing_entity = BillingEntity.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @billing_entity }
    end
  end

  # GET /billing_providers/1/edit
  def edit
    @invoices = Invoice.all
    @billing_entity = BillingEntity.find(params[:id])
  end

  # POST /billing_providers
  # POST /billing_providers.xml
  def create
    @billing_entity = BillingEntity.new(params[:billing_entity])
    @invoices = Invoice.all
    respond_to do |format|
      if @billing_entity.save
        format.html { redirect_to(@billing_entity, :notice => 'Billing entity was successfully created.') }
        format.xml  { render :xml => @billing_entity, :status => :created, :location => @billing_entity }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @billing_entity.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /billing_providers/1
  # PUT /billing_providers/1.xml
  def update
    @billing_entity = BillingEntity.find(params[:id])
    @invoices = Invoice.all
    respond_to do |format|
      if @billing_entity.update_attributes(params[:billing_entity])
        format.html { redirect_to(@billing_entity, :notice => 'Billing entity was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @billing_entity.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /billing_providers/1
  # DELETE /billing_providers/1.xml
  def destroy
    @billing_entity = BillingEntity.find(params[:id])
    @billing_entity.destroy

    respond_to do |format|
      format.html { redirect_to(billing_entities_url) }
      format.xml  { head :ok }
    end
  end
end
