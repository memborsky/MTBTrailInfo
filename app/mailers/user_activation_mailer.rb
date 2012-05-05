class UserActivationMailer < ActionMailer::Base
  default from: "MTB Trail Site"
  
  def user_activated(user)
    @user = user
    mail(:to => user.email, :subject => "User Activated")
  end

  def notify_admins_user_activated(user)
    @user = user
    allUsers = User.all
    
#    toAdmins = []
    
#    allUsers.for do |adminuser|
#      if(adminuser.admin)
#        toAdmins.push adminuser
#      end
#    end

    toAdmins = User.all.map(&:email)
    
    logger.debug "user registered to " + toAdmins.inspect

    mail(:to => toAdmins, :subject => "New User Activated: " + user.name + " (" + user.email + ")")
  end
  
  def user_registered(user)
    @user = user
    
    toAdmins = User.where(:first, :conditions=>["admin = 'true'"]).all.map(&:email)
    logger.debug "user registered to " + toAdmins.inspect

    mail(:to => toAdmins, :subject => "New User Registered: " + user.name + " (" + user.email + ")")
    
  end
end
