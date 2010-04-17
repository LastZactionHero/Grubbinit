class Restaurant < ActiveRecord::Base
  has_many :menu_items


  def doesRestaurantContainSearch( search_terms )
    ret = true
  
    search_terms.each do |term|
      if !name.downcase.include? term.downcase and !description.downcase.include? term.downcase
	    ret = false
	  end
    end
  
    return ret
  end
  
end