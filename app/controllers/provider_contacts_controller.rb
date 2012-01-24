class ProviderContactsController < ApplicationController

  before_filter :authenticate_user!
  before_filter :get_user
  
  def index
    @contacts = @user.contacts
  end

  def new
    @parent = @user
    @contact = Contact.new
  end

  def create
    @parent = @user
    
    parsedatefield(:contact,:contactsince)
    parsedatefield(:contact,:lastcommunicatedon)

    @contact = @user.contacts.new(params[:contact])

    if @contact.save
      redirect_to(user_provider_contacts_path(@user), :notice => 'Contact was successfully created.')
      #redirect_to patients_url
    else
      render :action => "new"
    end
  end

  def edit
    @parent = @user
    @contact = Contact.find(params["id"])
  end

  def update
    @parent = @user

    parsedatefield(:contact,:contactsince)
    parsedatefield(:contact,:lastcommunicatedon)

    @contact = Contact.find(params[:id])
    if @contact.update_attributes(params[:contact])
      redirect_to(user_provider_contacts_path(@user), :notice => 'Contact was successfully updated.')
    else
      render :action => "edit"
    end
  end

  private
  def get_user
    @user = User.find(params[:user_id])
  end
end
