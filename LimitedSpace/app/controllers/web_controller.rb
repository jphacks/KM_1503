class WebController < ApplicationController
    def index
        @spaces = Space.getSpaces(1,1)
        render action: "index"
    end

    def files
        render action: "files" 
    end
end
