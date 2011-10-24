class ApplicationController < ActionController::Base
  protect_from_forgery
 
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

  def conversation_title(conversation)
    members_of_conversation = conversation.users.where("users.id <> ?", current_user.id)
    if members_of_conversation.count >= 3
      members_of_conversation[0..2].map{|user| user.full_name}.join(", ") + " and #{pluralize(members_of_conversation.count - 3,"other", "others")}"
    else
      members_of_conversation[0..2].map{|user| user.full_name}.join(", ")
    end
  end

  helper_method :conversation_title

end
