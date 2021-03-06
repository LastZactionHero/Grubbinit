#require 'restaurant'

class SearchController < ApplicationController
  def index
    session[:order_state] = :none
	@search_term = ""
	@search_zip = ""
	
	# Get search terms from parameters
	params.each do |key, value|
	  @search_term = value.to_s if key.to_s == "searchValue"
	  @search_zip = value.to_s if key.to_s == "zipValue"
	end
	
	#Remove default values
	@search_term = "" if @search_term == "e.g. Thai, $15.99, Westport"
	@search_zip = "" if @search_zip == "zipcode"
	
	search_terms = @search_term.split
	
	# Select restaurant list
	@restaurants
	
	# Just search term, no zip
	if !@search_term.empty? and @search_zip.empty?
	  @restaurants = Restaurant.all.select{ |restaurant| restaurant.doesRestaurantContainSearch( search_terms ) == true }
	# Just zip, no search term
	elsif @search_term.empty? and !@search_zip.empty?
	  @restaurants = Restaurant.all.select{ |restaurant| restaurant.address.downcase.include? @search_zip.downcase }
	# Search term and zip
	else !@search_term.empty? and !@search_zip.empty?
	  @restaurants = Restaurant.all.select{ |restaurant| 
			restaurant.doesRestaurantContainSearch( search_terms ) == true and
			restaurant.address.downcase.include? @search_zip.downcase
			}
	end
	

  end

end
