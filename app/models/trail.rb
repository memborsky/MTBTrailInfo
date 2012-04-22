class Trail < ActiveRecord::Base
  has_one :status, :dependent => :destroy

end
