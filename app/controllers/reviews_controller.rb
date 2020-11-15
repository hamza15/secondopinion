class ReviewsController < ApplicationController

    get '/reviews/:id' do
        if Helpers.is_logged_in?(session)
            @review = Review.find_by(id: params[:id])
            if @review 
                erb :'reviews/show'
            else
                redirect '/reviews'
            end
        else
            @error = "Please log in."
            erb :'users/login'
        end
    end

    get '/reviews/new' do
        if Helpers.is_logged_in?(session)
            @user = Helpers.current_user(session)
            erb :'/reviews/new'
        else
            @error = "Please log in."
            erb :'users/login'
        end
    end

    #make a post request to '/reviews'
    post '/reviews' do
        user = Helpers.current_user(session)
        review = user.reviews.build(params)
        if review.save
            redirect '/reviews'
        else
            @error = "Invalid data. Please try again."
            erb :'/reviews/new'
        end
    end 

    #READ

    #make a get request to '/reviews'
    # get '/reviews' do
    #     if Helpers.is_logged_in?(session)
    #         @user = Helpers.current_user(session)
    #         @reviews = Review.all.reverse
    #         erb :'reviews/index'
    #     else
    #         @error = "Please log in."
    #         erb :'users/login'
    #     end
        
    # end

    #UPDATE

    #make a get request to '/reviews/:id/edit'
    get '/reviews/:id/edit' do
        if Helpers.is_logged_in?(session)
            @review = Review.find(params[:id])
            erb :'/reviews/edit'
        else
            @error = "Please log in."
            erb :'users/login'
        end
    end


    #make a post request to '/reviews/:id'
    patch '/reviews/:id' do
        @review = Review.find(params[:id])
        if !params["review"]["stars"].empty? && !params["review"]["post"].empty? 
            @review.update(params["review"])
            redirect "/reviews/#{params[:id]}"
        else
            @error = "Invalid data. Please try again."
            erb :'/reviews'
        end
    end
    #DELETE

    #make a post request to '/reviews/:id'
    delete '/reviews/:id' do
        if Helpers.is_logged_in?(session)
            @user = Helpers.current_user(session)
            review = Review.find(params[:id])
            review.destroy
            redirect '/doctors'
        else
            @error = "Please log in."
            erb :'users/login'
        end
    end
end