class StatusDetailsOld

  def initialize(trailName, statusString, lastUpdate, imageUrl)
      @trailName = trailName
      @statusString = statusString
      @lastUpdate = lastUpdate
      @imageUrl  = imageUrl
  end
  
  def imageurl
    @imageUrl
  end
  
  def lastupdate  
    @lastUpdate
  end
  
  def statusstring
    @statusString
  end
  
  def trailname
    @trailName
  end
  
end

