require 'pry'

class Ride < ActiveRecord::Base
    belongs_to :user
    belongs_to :attraction
    
    def take_ride
        error = ""
        #binding.pry
        #Perform checks to make sure user can ride ride, returning errors if not
        if user.tickets < attraction.tickets
            error += "Sorry. You do not have enough tickets to ride the #{attraction.name}."
        end
        if user.height < attraction.min_height
            if !error.empty?
                error += " You are not tall enough to ride the #{attraction.name}."
            else
                error = "Sorry. You are not tall enough to ride the #{attraction.name}."
            end
        end
        if !error.empty?
            return error
        end
        #If we get this far, update the relevent user data with the attraction stats
        user.tickets -= attraction.tickets
        user.nausea += attraction.nausea_rating
        user.happiness += attraction.happiness_rating
        user.save
    end
end
