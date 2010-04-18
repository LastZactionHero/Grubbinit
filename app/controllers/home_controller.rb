class HomeController < ApplicationController
  def index
    session[:order_state] = :none
  end

end
