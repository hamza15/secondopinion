class ReviewsController < ApplicationController


    get '/reviews/:id/edit' do
        if Helpers.is_logged_in?(session)
            @review = Review.find(params[:id])
            erb :'/reviews/edit'
        else
            @error = "Please log in."
            erb :'users/login'
        end
    end

    patch '/reviews/:id' do
        @review = Review.find(params[:id])
        if !params["review"]["stars"].empty? && !params["review"]["post"].empty? 
            @review.update(params["review"])
            @review = Review.find(params[:id]).doctor_id
            redirect "/doctors/#{@review}"
        else
            @error = "Invalid data. Please try again."
            erb :'/reviews'
        end
    end

    delete '/reviews/:id' do
        if Helpers.is_logged_in?(session)
            @user = Helpers.current_user(session)
            review = Review.find(params[:id])
            @id = review.doctor_id
            review.destroy
            redirect "/doctors/#{@id}"
        else
            @error = "Please log in."
            erb :'users/login'
        end
    end
end