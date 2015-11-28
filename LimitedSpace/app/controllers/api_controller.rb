class ApiController < ApplicationController
    def getLimitedSpaces
        lat = params[:lat]
        lng = params[:lng]
        render :json => Space.getSpaces( lat, lng) 
    end

    def getSpaceDetail
        if params[:space_id].nil?
            ret = Hash.new
            ret[:code] = "400"
            render :json => ret
            return
        end
        spaceId = params[:space_id]
        structure = getFileStructure(spaceId)
    end
end
def getFileStructure(spaceId)
    # Fileたちを取得
    files = DataFile.search_with_space_id(spaceId)
    structure = Hash.new
    structure[:files] = Array.new
    structure[:folders] = Hash.new
    files.each do |file|
        path = file.path
        currentDir = structure
        arr = path.split("/")
        arrLength = arr.length
        arrLength.times do |i|  
            fname = arr[i]
            if arrLength-1 == i
                currentDir[:files].push(file.getInfo) 
            else
                if !currentDir[:folders].has_key?(fname)
                    currentDir[:folders][fname] = Hash.new
                    currentDir[:folders][fname][:files] = Array.new
                    currentDir[:folders][fname][:folders] = Hash.new
                end
                currentDir = currentDir[:folders][fname]
            end
        end
    end
    render :json => structure
end

