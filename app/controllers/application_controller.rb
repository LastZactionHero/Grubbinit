# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  before_filter :generate_cart_id
  
  def generate_cart_id
    session[:cart_id] ||= "id" + rand(10000).to_s + "e"
	session[:items] ||= []
  end
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end
