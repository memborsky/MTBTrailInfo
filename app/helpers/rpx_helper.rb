#skip_before_filter :verify_authenticity_token, :only=>['rpx']

module RpxHelper
  def self.get_user(session)
    if(session['rpx_identifier'] == nil || session['user_id'] == nil)
      return nil
    end
    user = User.find(:first, :conditions=>["rpx_identifier = ? and id = ?", session['rpx_identifier'], session['user_id']])
  end
  
  def self.logged_in(session)
    user = get_user(session)
    return user != nil
  end
  
  def self.is_admin(session)
    user = get_user(session)
    
    if(user == nil)
      return false
    else
      return user.admin
    end
  end
  
  def self.authenticate(request)
     Rails.logger.debug 'rpx login'
     require 'net/http'
     require 'net/https'

     # login janrain callback
     # token
     token = request[:token]
     
     
     apiKey = ENV['RPX_KEY'] #### replace this with your api key
     # http request auth_info
     host = 'rpxnow.com'
     path = '/api/v2/auth_info?apiKey='+apiKey+'&token='+token
     http = Net::HTTP.new(host, 443)
     http.use_ssl = true
     resp, result = http.get(path)

     data = ActiveSupport::JSON.decode result
     
     Rails.logger.debug  data.inspect

     if data['stat'] == 'ok'
       Rails.logger.debug 'login successful'
       return data
       
     else
       return nil
     end
    end

end
