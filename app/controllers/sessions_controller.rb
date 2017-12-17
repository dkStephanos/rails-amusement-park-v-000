class SessionsController < ApplicationController
    
    def new
        
    end
    
    def create
       if !params[:user][:name].nil? && !params[:user][:name].empty?
           @user = User.find_by(name: params[:user][:name])
           session[:user_id] = @user.id
           redirect_to @user
        else
           redirect_to action: 'new' 
        end
    end
    
    def destroy
        if session.include? :user_id
            session[:user_id] = nil
            redirect_to root_path
        end
    end
    
    def login
        
    end
end