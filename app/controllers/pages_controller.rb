class PagesController < ApplicationController

  def home
  end

  def time_zone
    tz = params[:tz].to_i
    timezone = ActiveSupport::TimeZone[tz*60*60].name
    session[:tz] = params[:tz]
    session[:timezone] = timezone
    render :nothing => true
  end

end
