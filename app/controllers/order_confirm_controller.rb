require 'rubygems'
require 'gmail'

class OrderConfirmController < ApplicationController

  def is_delivered()
    puts "is_delievered()\n"
	
    ret = :false
	
	if receive_email() == :delivery_confirmed
	  puts "receive_email() returned :delievery_confirmed\n"
	  ret = :true
	end
	
	return ret
  end
  
  
  def is_in_route()
    puts "is_in_route()\n"
	ret = :false
	
	if receive_email() == :picked_up
	  puts "receive_email() returned :picked_up\n"
	  ret = :true
	end
	
	return ret
  end
  
  
  def is_driver_found()
    puts "is_driver_found()\n"
	
    ret = :false
	
	if receive_email() == :driver_found
	  puts "receive_email() returned :driver_found\n"
	  ret = :true
	end
	
	return ret
  end


  def receive_email
    puts "receive_email()\n"
    ret = :none
	
    gmail = Gmail.new("grubbinit", "lulusthai") do |g|
	  read_count = g.inbox.count(:unread) # => .count take the same arguments as .emails
	  puts read_count
	  unread = g.inbox.emails(:unread)
	  unread.each do |email| 
 
        puts email.body
	    if ( email.body =~ /RequestDriver/ )
	      puts "Driver Found"
          email.mark(:read)	
		  ret = :driver_found
	      # also extract phone number/email addy also send out direction
          #also send out an email for pickup confirmatio
        end
  
        if ( email.body =~ /ConfirmPickup/ )
		  ret = :picked_up
          puts "Order Picked up"
          email.mark(:read)
        end

        if ( email.body =~ /ConfirmDelivery/ )
		  ret = :delivery_confirmed
          puts "Order Delivered"
          email.mark(:read)
	    end
	  end
	end
	
	return ret
  end

  def send_email( message_text )
    gmail = Gmail.new("grubbinit", "lulusthai") 
    new_email = MIME::Message.generate
    new_email.to"18168077599@tmomail.net"
    #new_email.subject "This is a system email"
    new_email.subject message_text
	plain, html = new_email.generate_multipart('text/plain', 'text/html')
    plain.content = message_text
    html.content = "<p>#{message_text}</p>"
    gmail.send_email( new_email )
    gmail.logout
  end


  def index
	@display_state = :display_none
	
	case session[:order_state]
	  when :none
		@display_state = :display_submitted
		
	  when :submitted
		@display_state = :display_submitted
		
	  when :driver_contacted
		@display_state = :display_submitted
		
	  when :driver_dispatched
        @display_state = :display_contacted
		
	  when :driver_in_route
		@display_state = :display_in_route
		
	  when :done
	    @display_state = :display_done
		
	  else
		@display_none
		
	  end
  end
  
  
  
  def update
    puts "update()\n"
	
	case session[:order_state]
	  when :none
		puts "state :none\n"
		# Send request to drivers
		send_email( "(RequestDriver) Request for Driver. Payment: $6.00. Accept?" )
	    session[:order_state] = :submitted
		
	  when :submitted
	    puts "state :submitted\n"
	    session[:order_state] = :driver_contacted
		
	  when :driver_contacted
	    puts "state :driver_contacted\n"
		
        if is_driver_found() == :true
		  puts "is_driver_found() returned true!\n"
		  send_email( "(ConfirmPickup) Respond to confirm pickup." )
		  session[:order_state] = :driver_dispatched
		end
		
	  when :driver_dispatched
	    puts "state :driver_dispatched\n"
	    if is_in_route() == :true
		  puts "is_in_route() returned true!\n"
		  send_email( "(ConfirmDelivery) Respond to confirm delivery." )
		  session[:order_state] = :driver_in_route
		end
		
	  when :driver_in_route
	    puts "state :driver_in_route\n"
	    if is_delivered() == :true
		  puts "is_delivered() returned true!\n"
	      session[:order_state] = :done
		end
		
	  when :done
		
	  else
	    session[:order_state] = :none
	  end

	redirect_to :action => "index"
  end
end

