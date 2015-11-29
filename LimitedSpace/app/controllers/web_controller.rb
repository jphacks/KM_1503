class WebController < ApplicationController
    def index
        render action: "index"
    end

    def files
        render action: "files" 
    end
end
