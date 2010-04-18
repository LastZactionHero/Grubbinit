require 'menu_item'

class MenuController < ApplicationController
  def index
    @restaurant_name = ""
	
	params.each do |key,value|
	  @restaurant_name = value.to_s if key.to_s == "restaurant"  
	end	  
	
	@items = MenuItem.all.select{ |item| item.restaurant == @restaurant_name }
  end

  def update
  end

end
