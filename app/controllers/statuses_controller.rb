class StatusesController < ApplicationController
  before_filter :logged_in, :only =>[:edit, :update]
    
  def get_status_list
      logger.debug 'enter get_status_list'
      @trails = Trail.all
      statusmap = StatusesHelper.status_map
      
      @statusinfo = []
      StatusesHelper.status_map.keys.each do |key|
        @statusinfo.push(StatusInfo.new(key, StatusesHelper.status_map[key], StatusesHelper.image_map[key]))
      end
           
      @statuses = []
      
      logger.debug 'got status info, now getting trails'
      
      @trails.each do |trail|
#        logger.debug trail.inspect
        statusString = nil
        updatedAt = nil
        statusImage = nil
                
        if trail.status != nil
          statusString = trail.status.details;#statusmap[trail.status.level]
          updatedAt = trail.status.updated_at                         
          statusImage =StatusesHelper.image_map[trail.status.level]
        end
        
        statusinfo = TrailStatusDetails.new(trail.id, trail.name, statusString, updatedAt, statusImage)
        @statuses.push statusinfo
      end
      logger.debug 'exit get_status_list'
      
      @statuses.sort!{|a,b| a.trailname <=> b.trailname}

  end
  
  def show
      logger.debug 'StatusesController.show'
          
      get_status_list  
      
      respond_to do |format|
        format.html  # index.html.haml
        format.rss {@statuses.sort!{|a,b| b.lastupdate <=> a.lastupdate}}
        format.json  { render :json => @statuses }
        format.xml  { render :xml => @statuses }
      end  
  end

  def edit
      logger.debug 'StatusesController.edit'
      if params[:method] = :put
        update
      end
      
      get_status_list   
      
  end
 

  def update
    begin
      @trail = Trail.find params[:trail]
    
      @status = @trail.status
            
      logger.debug @status.inspect
      @status.update_attributes(:level => params[:statusid], :details=>params[:statusdetails]);

    rescue StandardError => bang
      logger.debug "Error running script "
    end
  end

  def table
  
    logger.debug params.inspect
    
    columnWidth = params[:columns]
    if columnWidth == nil
      columnWidth = 1
    else
      columnWidth = columnWidth.to_i
    end
    
    columnCount = 0
    
    returnText = "<table id='statustable'>"
    
    get_status_list
      
    
    @statuses.each do |status|
      if(columnCount == 0)
        returnText += "<tr>"
      end
      
      if(status != nil)
        returnText += "<td><img src='"
        returnText += status.imageurl
        returnText += "'/></td><td><font id='trailname'>" 
        returnText += status.trailname 
        returnText += "</font></td>"
      end
      columnCount += 1
      
      if(columnCount == columnWidth)
        returnText += "</tr>"
        columnCount = 0
      end
    
    end
    
    returnText += "</table>"
    
    if(params[:showlegend] != nil)
      returnText += "<table id='traillegend'>"

      legendColumnCount = 0
      StatusesHelper.status_map.keys.each do |key|
        if(legendColumnCount == 0)
          returnText += "<tr>"
        end
      
        if(status != nil)
          returnText += "<td><font id='traillegendtext'>" 
          returnText += StatusesHelper.status_keystrings[key]
          returnText += ": " 
          returnText += StatusesHelper.status_map[key]
          returnText += "</font></td>"
        end
        legendColumnCount += 1
      
        if(legendColumnCount == columnWidth)
          returnText += "</tr>"
          legendColumnCount = 0
        end
      end    
      returnText += "</table>"
    end
  
    respond_to do |format|
      format.html { render :text => returnText }

    end
     
  end
    
  private 
    def logged_in
      isLoggedIn = (RpxHelper::logged_in session)
      if(!isLoggedIn)
        redirect_to login_path
      end
    end

end

