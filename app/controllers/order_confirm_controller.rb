class OrderConfirmController < ApplicationController
  def index
	@display_state = :display_none
	
	case session[:order_state]
	  when :none
		@display_state = :display_submitted
		
	  when :submitted
		@display_state = :display_submitted
		
	  when :driver_contacted
		@display_state = :display_contacted
		
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
	case session[:order_state]
	  when :none
	    session[:order_state] = :submitted
		
	  when :submitted
	    session[:order_state] = :driver_contacted
		
	  when :driver_contacted
		session[:order_state] = :driver_dispatched
		
	  when :driver_dispatched
	    session[:order_state] = :driver_in_route
		
	  when :driver_in_route
	    session[:order_state] = :done
		
	  when :done
		
	  else
	    session[:order_state] = :none
		
	  end

	redirect_to :action => "index"
  end
end
