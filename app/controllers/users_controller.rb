require 'pry'

class UsersController < ApplicationController
    
    def create
        @user = User.new(name: params[:user][:name])
        @user.password = params[:user][:password]
        @user.nausea = params[:user][:nausea]
        @user.happiness = params[:user][:happiness]
        @user.tickets = params[:user][:tickets]
        @user.height = params[:user][:height]
        @user.admin = params[:user][:admin]
        
        if @user.save
            session[:user_id] = @user.id
            redirect_to @user
        else
            redirect_to action: 'new', controller: 'sessions'
        end
    end
    
    def new
        
    end
    
    def show
        if logged_in?
            @user = User.find_by(id: session[:user_id])
        else
            redirect_to root_path
        end
    end
    
    def update
        #Set the attraction from params and the current_user to be updated
        attraction = Attraction.find(params[:id])
        @user = current_user
        
        #Checks to make sure user meets min requirments, redirecting with errors if not
        if @user.tickets < attraction.tickets
            flash[:tickets] = "You do not have enough tickets to ride the #{attraction.name}"
        end
        if @user.height < attraction.min_height
            flash[:height] = "You are not tall enough to ride the #{attraction.name}"
        end
        if !flash[:tickets].nil? || !flash[:height].nil?
            redirect_to current_user
        else
            #If we get here, passed requirements, so update user and redirect to show page
            #while setting a success message
            @user.tickets -= attraction.tickets
            @user.happiness += attraction.happiness_rating
            @user.nausea += attraction.nausea_rating
            @user.save
    
            flash[:success] = "Thanks for riding the #{attraction.name}!"
            
            redirect_to current_user
        end
    end
end