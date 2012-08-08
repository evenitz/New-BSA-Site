class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :redirect_reach
  
  def redirect_reach
    if request.host.include? "reachbrown.com"
      redirect_to "http://reachbrown.com/reach"
    end
  end

end
