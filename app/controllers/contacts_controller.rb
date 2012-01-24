class ContactsController < ApplicationController
  before_filter :authenticate_user!
  def new
    @parent,@parentname = find_entity
    @title = @parentname + "- Contacts - New"
    puts "in new"
    puts @parent
    puts @parent.class.to_s
    @contact = @parent.contacts.new
  end


  def edit
    @parent,@parentname = find_entity

    @title = @parentname + "- Contacts - Edit"
    @contact =  @parent.contacts.where(:id=> params[:id]).first
  end


  def update
    @parent,@parentname = find_entity

    parsedatefield(:contact,:contactsince)
    parsedatefield(:contact,:lastcommunicatedon)

    @contact = @parent.contacts.where(:id=>params[:id]).first
    if @contact.update_attributes(params[:contact])
      redirect_to(@parent, :notice => 'Contact was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def picture
    @parent,@parentname = find_entity
    @contact =  @parent.contacts.where(:id=> params[:id]).first
    send_data @contact.picture, :type => 'image/jpeg',:disposition=>'inline'
  end


  def create
    @parent,@parentname = find_entity

    parsedatefield(:contact,:contactsince)
    parsedatefield(:contact,:lastcommunicatedon)


    @contact = @parent.contacts.new(params[:contact])

    if @contact.save
      redirect_to(@parent, :notice => 'Contact was successfully created.')
      #redirect_to patients_url
    else
      render :action => "new"
    end
  end

  private
	def find_entity  
	  params.each do |name, value|  
	    if name =~ /(.+)_id$/  
	      @parent = $1.classify.constantize.where(:id=>value).first
        p @parent
	      return  @parent,@parent.class.to_s.pluralize
	    end  
	  end  
	  nil  
	end
end
