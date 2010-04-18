class OrderItem
  attr_accessor :order_count, :menu_item
end

class MenuItem < ActiveRecord::Base

  # Find how many of this item are in the cart
  def getSessionCount( session )
    order_count = 0

	session[:items].each do |session_item|
	    if session_item.menu_item.name == name and session_item.menu_item.restaurant == restaurant
		  order_count = session_item.order_count
		end
	end

    return order_count
  end

end
