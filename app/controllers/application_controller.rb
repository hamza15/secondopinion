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

  def redirect_if_not_loggedin
    unless Helpers.is_logged_in?(session)
      redirect '/login'
    end
  end

  def redirect_if_not_authorized
    unless Helpers.current_user(session) == @review.user
      redirect '/failure'
    end  
  end
end
