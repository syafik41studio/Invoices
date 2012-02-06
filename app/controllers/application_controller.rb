class ApplicationController < ActionController::Base
  protect_from_forgery
  helper :all

  before_filter :set_time_zone
 
  def parsedatefield(entity,fieldname)
    if !params[entity][fieldname].nil?
      params[entity][fieldname] = parsedate(params[entity][fieldname])
    end
  end

  def parsedate(datevalue)
	  retvalue = datevalue
	  begin
		  retvalue = Date.strptime(datevalue,DateTime::DATE_FORMATS[:default]).to_s(:db) 		if  !datevalue.empty?
	  rescue
		  p "Date parsing failed for , %s" % [datevalue]
	  end 
	  retvalue 
  end

  def conversation_title(conversation, user = current_user)
    members_of_conversation = conversation.users.where("users.id <> ?", user.id)
    if members_of_conversation.count >= 3
      members_of_conversation[0..2].map{|u| u.full_name}.join(", ") + " and #{pluralize(members_of_conversation.count - 3,"other", "others")}"
    else
      members_of_conversation[0..2].map{|u| u.full_name}.join(", ")
    end
  end

  def is_my_profile?(user)
    current_user.eql?(user)
  end

  def controller_name
    params[:controller]
  end

  def action_name
    params[:action]
  end

  def set_time_zone
    unless session[:timezone].blank?
      Time.zone = session[:timezone]
    else
      Time.zone  = "Pacific Time (US & Canada)"
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to root_url
  end

  helper_method :conversation_title, :is_my_profile?

end
