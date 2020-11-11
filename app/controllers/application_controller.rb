require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get "/" do
    erb :welcome
  end

  get "/signup" do
    erb :'users/signup'
  end

  post "/signup" do
    if params[:email].empty?
      redirect to '/failure'
    end
    user = User.new(:email => params[:email], :password => params[:password], :first_name => params[:first_name], :last_name => params[:last_name])
    
    if user.save
      redirect "/login"
    else
      redirect "/failure"
    end
  end

  get "/login" do
    erb :'/users/login'
  end

  post "/login" do
    ##your code here
    user = User.find_by(:email => params[:email])
 
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/account"
    else
      redirect "/failure"
    end
  end

  get '/account' do
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      erb :'account'
    else
      erb :'failure'
    end
  end

  get "/failure" do
    erb :failure
  end

  get "/logout" do
    session.clear
    redirect "/"
  end
end
