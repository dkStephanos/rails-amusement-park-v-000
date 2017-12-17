class AttractionsController < ApplicationController
    
    def index
        @attractions = Attraction.all   
    end
    
    
    def show
        @attraction = Attraction.find(params[:id])
    end
    
    def new
        @attraction = Attraction.new
    end
    
    def create
        @attraction = Attraction.new(attraction_params)
        if @attraction.save
            redirect_to @attraction
        else
            flash[:error] = "Could not save the attraction."
            redirect_to action: "index"
        end
    end
    
    def edit
        current_attraction
    end
    
    def update
        current_attraction.update(attraction_params)
        if current_attraction.save
            redirect_to current_attraction
        else
            flash[:error] = "Could not save the attraction."
            redirect_to action: "index"
        end
    end
    
    private
    
    def current_attraction
        @attraction = Attraction.find(params[:id])
    end
    
    def attraction_params
       params.require(:attraction).permit(:name, :min_height, :happiness_rating, :nausea_rating, :tickets) 
    end
    
end