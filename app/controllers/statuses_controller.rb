class StatusesController < ApplicationController
  
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

  end
  
  def show
      logger.debug 'StatusesController.show'
      get_status_list  
      
      respond_to do |format|
        format.html  # index.html.haml
        format.rss
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
   
end

