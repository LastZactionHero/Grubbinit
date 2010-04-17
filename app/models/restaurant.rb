class Restaurant < ActiveRecord::Base
  has_many :menu_items

  def self.doesRestaurantContainSearch( restaurant, search_terms )
    ret = :true
  
    search_terms.each do |term|
      if !restaurant.name.downcase.include? term.downcase and !restaurant.description.downcase.include? term.downcase
	    ret = :false
	  end
    end
  
    return ret
  end
  
end