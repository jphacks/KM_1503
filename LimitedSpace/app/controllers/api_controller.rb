class ApiController < ApplicationController
    protect_from_forgery except: :createLimitedSpaces
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

    def createLimitedSpaces
        userId = params[:user_id]
        if userId.nil?
            # ユーザー登録処理 
            userId = 1
        end
        name = params[:name]
        span = params[:span]
        radius = params[:radius]
        lat = params[:lat]
        lng = params[:lng]
        iconType = params[:icon_type]

        space = Space.new
        space.name = name
        space.span = span
        space.radius = radius
        space.lat = lat
        space.lng = lng
        # アイコン関連の処理
        success = space.save
        if success
            ret = Hash.new
            ret[:code] = 200
            data = Hash.new
            data[:space_id] = space.id
            data[:user_id] = userId
            ret[:data] = data
        else
            # 保存失敗時 
            ret = Hash.new
            ret[:code] = 500
        end
        render :json => ret
    end

    def upload
        file = params[:file]

        name = file.original_filename

        filedata = DataFile.new 
        filedata.path = "#{params[:current_dir]}#{name}"
        filedata.save
        space = Space.find(params[:space_id].to_i)

        #File.open("#{space.getDataPath}#{filedat.id}", "wb"){ |f|
        File.open("#{space.getPath}test", "wb"){ |f|
            f.write(file.read)
        }
        render :text => "save"
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

