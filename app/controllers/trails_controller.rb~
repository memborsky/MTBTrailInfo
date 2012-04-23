class TrailsController < ApplicationController

  def show
    id = params[:id] 
    trail = Trail.find id
    @trail = trail
    
    logger.debug "show-" + trail.inspect

  end

  def index
      @trails = Trail.all
      
      respond_to do |format|
        format.html  # index.html.haml
        format.json  { render :json => @trails.to_json(:include => [:status], :exclude =>[:updated_at, :created_at, :id, :trailid]) }
        format.xml  { render :xml => @trails.to_xml(:include => [:status], :exclude =>[:updated_at, :created_at, :id, :trailid]) }
      end
  end

  def new
    # default: render 'new' template
  end

  def create
    newTrail = Trail.create!(params[:trail])
    newTrail.status = Status.create!
    newTrail.status.level = StatusesHelper::GREEN
    #newTrail.status
    
    @trail = newTrail    
    flash[:notice] = "#{@trail.name} was successfully created."
    redirect_to trails_path
    

  end

  def edit
    @trail = Trail.find params[:id]
  end

  def update
    @trail = Trail.find params[:id]
    @trail.update_attributes!(params[:trail])
    flash[:notice] = "#{@trail.name} was successfully updated."
    redirect_to trail_path(@trail)
  end

  def destroy
    @trail = Trail.find(params[:id])
    @trail.destroy
    flash[:notice] = "Trail '#{@trail.name}' deleted."
    redirect_to trails_path
  end

end
