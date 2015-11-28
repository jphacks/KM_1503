class Space < ActiveRecord::Base
  soft_deletable

  def isExists
    #　分を秒に変換
    spanSecond = self.span.to_i * 60
    til = self.created_at.to_i + 32400 + spanSecond
    isExists = true
    if Time.now.to_i > til
      isExists = false
    end
    return isExists
  end

  def isInRange( lat , lng )
    # 緯度経度 がない場合は false を返す
    if self.lat.nil? || self.lng.nil?
        return false 
    end
    til =  Math.sqrt(( self.lat.to_i ** 2 ) + ( self.lng.to_i ** 2 ))
    isInRange = false
    if Math.sqrt(( lat.to_i ** 2 ) + ( lng.to_i ** 2 )) <= til
      isInRange = true
    end
    return isInRange
  end

  def self.isOverwrap( space1, space2)
    r = Math.sqrt(( space2.lat - space1.lat ) ** 2 ) + Math.sqrt(( space2.lng - space1.lng ) ** 2 )
    isOverwrap = false
    if( r <= space1.radius + space2.radius )
        isOverwrap = true
    end
    p "#{r}   #{( space1.radius + space2.radius )}"
    return isOverwrap
  end

  def self.isDuplicate( space1, space2)
    isDuplicate = false
    if( Space.isOverwrap( space1, space2) ) 
        isDuplicate = space1.name == space2.name
    end
    return isDuplicate
  end

  def self.getSpaces( lat, lng )
    spaces = Space.without_soft_destroyed
    retSpaces = Array.new
    spaces.each do |space|
      if ( space.isExists && space.isInRange( lat, lng) )
        retSpaces << space
      end
    end
    return retSpaces
  end

end
