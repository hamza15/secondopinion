class SessionsController < ApplicationController

    get "/login" do
        if Helpers.is_logged_in?(session)
            redirect '/doctors'
        else
            erb :'users/login'
        end
    end

    post "/login" do
        user = User.find_by(:email => params[:email])
        
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect "/account"
        else
            @error = "Invalid credentials. Please try again."
            redirect "/login"
        end
    end




end