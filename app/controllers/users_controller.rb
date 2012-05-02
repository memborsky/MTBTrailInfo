class UsersController < ApplicationController
  before_filter :logged_in, :except=>[:login, :new]

  def index
    @users = User.all
              
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def login
    if(params[:token] != nil)
      data = RpxHelper.authenticate params
      
      if(data != nil)
        # is this a known user?
        user = User.find(:first, :conditions=>["rpx_identifier = ?", data['profile']['identifier']])
        
        if(user == nil)
            flash[:notice] = "User does not exist";
        else
          session[:rpx_identifier] = user.rpx_identifier
          session[:user_id] = user.id
          redirect_to status_edit_path

        end
      end
    end
  end

  def new
    if(params[:token] != nil)
      data = RpxHelper.authenticate params
      
      if(data != nil)
        # is this a known user?
        user = User.find(:first, :conditions=>["rpx_identifier = ?", data['profile']['identifier']])
        
        if(user == nil)
            isAdmin = User.all.count == 0;
            
            userdata = {:name => data['profile']['formatted'], 
                    :email => data['profile']['email'], 
                    :rpx_identifier => data['profile']['identifier'], 
                    :admin=> isAdmin , 
                    :active=>isAdmin,
                    :first_name => data['profile']['name']['givenName'],
                    :last_name => data['profile']['name']['familyName']}
            User.create!(userdata)          
            
            if(isAdmin)
              render :text=> "Account registered as admin."  
            else
              render :text => "User created, you will receive an email when you are activated."
            end
        else
          render :text => "User already created."
        end
      end
    end
  end

  def logout
    reset_session
    flash[:message] = "Successful logout."
    redirect_to login_path
  end
  
  def update
    @user = User.find params[:id]
    @user.update_attributes!(params[:user])
    flash[:message] = "#{@user.name} was successfully updated."
    redirect_to users_path
  end
  
  def destroy
    @user = User.find params[:id]
    @user.destroy
    flash[:message] = "'#{@user.name}' deleted."
    redirect_to users_path
  end
  
  private 
    def logged_in
      isLoggedIn = (RpxHelper::logged_in session)
      if(!isLoggedIn)
        redirect_to login_path
      end
    end

end
