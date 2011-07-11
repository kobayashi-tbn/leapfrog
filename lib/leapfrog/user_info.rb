# To change this template, choose Tools | Templates
# and open the template in the editor.

module Leapfrog
  module UserInfo
    def current_user_id
      #puts Thread.current
      Thread.current[:lf_user_id]
    end

    def self.current_user_id=(user_id)
      #puts Thread.current
      Thread.current[:lf_user_id] = user_id
    end
    
  end
end
