require 'restaurant'

class SearchController < ApplicationController
  def index
	@search_term = ""
	@search_zip = ""
	
	# Get search terms from parameters
	params.each do |key, value|
	  @search_term = value.to_s if key.to_s == "searchValue"
	  @search_zip = value.to_s if key.to_s == "zipValue"
	end
	
	# Select restaurant list
	@restaurants = Restaurant.all.select{ |restaurant| 
		( restaurant.name.downcase.include? @search_term.downcase and !@search_term.empty? ) or
		( restaurant.description.downcase.include? @search_term.downcase and !@search_term.empty? ) or
		( restaurant.address.downcase.include? @search_zip.downcase and !@search_zip.empty? )
		}
  end

end
