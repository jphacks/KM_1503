class ApiController < ApplicationController
    def getLimitedSpaces
        lat = params[:lat]
        lng = params[:lng]
        render :json => Space.getSpaces( lat, lng) 
    end
end
