class Space < ActiveRecord::Base
  soft_deletable

  def isExists( create_at , span )
    til = created_at.to_i + span.to_i
    if Time.now.to_i > til
      exist = false
    else
      exist = true
    render :json => exist
  end

  def isInRange( lat , lng )
    til =  sqrt(( self.lat ** 2 ) + ( self.lng ** 2 ))
    if sqrt(( lat ** 2 ) + ( lng ** 2 )) <= til

      render :json => true
    else
      render :json => false
  end

  def getSpaces( lat, lng )
    spaces = Spece.without_soft_destroyed
    retspaces = Array.new
    each do |spaces|
      if ( Space.isExists && Space.isInRange )
        retspacces << spaces
      end
    end
    render :json => retspaces

  end

end
