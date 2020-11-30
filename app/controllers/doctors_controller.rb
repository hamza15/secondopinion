class DoctorsController < ApplicationController

    get '/doctors/:id/reviews/new' do
        redirect_if_not_loggedin
        @user = Helpers.current_user(session)
        @doctor = Doctor.find(params[:id])
        erb :'/reviews/new'
    end

    get '/doctors/:id' do
        redirect_if_not_loggedin
        @doctor = Doctor.find_by(id: params[:id])
        if @doctor 
            erb :'doctors/show'
        else
            redirect '/doctors'
        end
    end

    
    get '/doctors' do
        redirect_if_not_loggedin
        @user = Helpers.current_user(session)
        @doctors = Doctor.all
        erb :'doctors/index'
    end    

    post '/doctors/:id/reviews' do
        user = Helpers.current_user(session)
        review = user.reviews.build(stars: params[:stars], post: params[:post], datetime: Time.now.strftime("%d/%m/%Y %H:%M"))
        @doctor = Doctor.find(params[:id])
        @doctor.reviews << review
        if review.save
            #redirect '/doctors/:id'
            erb :'doctors/show'
        else
            @error = "Invalid data. Please try again."
            erb :'/reviews/new'
        end
    end 

end