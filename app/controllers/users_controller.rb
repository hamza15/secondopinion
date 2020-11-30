class UsersController < ApplicationController

    get "/signup" do
        erb :'users/signup'
    end
    
    post "/signup" do
        user = User.new(params)
        if user.save
            session[:user_id] = user.id
            redirect '/account'
        else
            @error = "Invalid fields. Please try again."
            erb :'users/signup'
        end
    end

    get '/logout' do
        session.clear
        redirect '/'
    end  
    
end