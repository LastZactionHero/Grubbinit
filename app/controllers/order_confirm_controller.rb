class OrderConfirmController < ApplicationController
  def index
  end

  def update
	redirect_to :action => "index"
  end
end
