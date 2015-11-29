class ApiController < ApplicationController
    protect_from_forgery except: :createLimitedSpaces
    def getLimitedSpaces
        lat = params[:lat]
        lng = params[:lng]
        render :json => Space.getSpaces( lat, lng) 
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
end
