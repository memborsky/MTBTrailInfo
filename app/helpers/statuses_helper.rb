module StatusesHelper
  GREEN = 1
  YELLOW = 2
  RED = 3
  BLUE = 4

  def self.status_map
    map = { GREEN => "Go Ride!",
            YELLOW => "Sloppy in Spots",
            RED => "Wet, Do Not Ride!",
            BLUE => "Freeze/Thaw"
          }
  end

  def self.image_map
    map = { GREEN => "/assets/green.png",
            YELLOW => "/assets/yellow.png",
            RED => "/assets/red.png",
            BLUE => "/assets/blue.png"
          }
  end

  def self.get_string(id)
    return status_map[id];
  end

end

class StatusInfo
  def initialize(id, text, imageUrl)
    @id = id
    @text = text
    @imageUrl = imageUrl
  end
  
  def id
    @id
  end
  
  def text
    @text
  end
  
  def imageurl
    @imageUrl
  end
end

class TrailStatusDetails

  def initialize(trailId, trailName, statusString, lastUpdate, imageUrl)
      @trailId = trailid
      @trailName = trailName
      @statusString = statusString
      @lastUpdate = lastUpdate
      @imageUrl  = imageUrl
  end
  
  def trailid
    @trailId
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

