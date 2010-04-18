require 'menu_item'

class MenuController < ApplicationController
  
  def calculateSubtotal
    subtotal = 0
	
	session[:items].each do |order_item|
	  subtotal += order_item.menu_item.price.to_f * order_item.order_count
	end
	
	return (subtotal*100).round/100.0
  end
  
  def calculateService
    subtotal = calculateSubtotal()
	if subtotal == 0
	  service = 0
	else
	  service = calculateSubtotal() * 0.15 + 2.00
	end
	
	return (service*100).round/100.0
  end
  
  def calculateTotal
    total = calculateSubtotal() + calculateService()
	return (total*100).round/100.0
  end
  
  def calculateItemCount
    item_count = 0
	
	session[:items].each do |order_item|
	  item_count += order_item.order_count
	end
	
	return item_count
  end
  
  
  def index
    @restaurant_name = params[:id].to_s
	
	params.each do |key,value|
	  @restaurant_name = value.to_s if key.to_s == "restaurant"  
	end	  
	
	@items = MenuItem.all.select{ |item| item.restaurant == @restaurant_name }
	
	@costSubtotal = "$" + calculateSubtotal().to_s
	@costService = "$" + calculateService().to_s
	@costTotal = "$" + calculateTotal().to_s
	@itemCount = calculateItemCount().to_s
  end

  def update
	restaurant_name = params[:restaurant].to_s
	item_name = params[:item].to_s.strip
	item_count = params[:count].to_i
	
    puts "update()"
	puts "Name: #{restaurant_name}"
	puts "Item: #{item_name}"
	puts "Count: #{item_count}"
	
	MenuItem.all.each do |item|
	  puts "item: #{item.name}\trestaurant: #{item.restaurant}\n"
	end
	
	new_items = MenuItem.all.select{ |item| item.name == item_name and item.restaurant == restaurant_name }
	
	puts "Adding #{item_count} of:"
	new_items.each do |item|
		puts "item: #{item.name}"
	end
	
	# Determine if this item already exists in the list
	exists = :false
	if session[:items].size > 0
	  session[:items].each do |order_item|
	    if order_item.menu_item.name == item_name and order_item.menu_item.restaurant == restaurant_name
	      exists = :true
		
		  #It exists. Just update the count
		  order_item.order_count = item_count
	    end
	  end
	end
	
	# Item does not exist, create a new item
	if exists == :false
	  new_order = OrderItem.new
	  new_order.order_count = item_count
	  new_order.menu_item = new_items[0]
	  
	  session[:items] << new_order
	end
		
	#session[:items].each do |session_item|
	#  puts "session_item: #{session_item.menu_item.name} #{session_item.order_count}"
	#end
	
    redirect_to :action => "index", :id => restaurant_name
  end

  def clearcart
    session[:items] = []
	redirect_to :controller => "home"
  end
  
end
