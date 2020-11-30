class ReviewsController < ApplicationController

    get '/reviews/:id/edit' do
        redirect_if_not_loggedin
        @review = Review.find(params[:id])
        redirect_if_not_authorized
        erb :'/reviews/edit'
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
        redirect_if_not_loggedin
        @user = Helpers.current_user(session)
        review = Review.find(params[:id])
        @id = review.doctor_id
        redirect_if_not_authorized
        review.destroy
        redirect "/doctors/#{@id}"
    end
end