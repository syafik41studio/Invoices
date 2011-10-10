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
 end
