# To change this template, choose Tools | Templates
# and open the template in the editor.

class LeapfrogObserver < ActiveRecord::Observer
    observe :user

    include Leapfrog::UserInfo

 
    def before_create(record)
      puts "LeapfrogObserver#before_create : #{current_user_id}"
      record.created_by = current_user_id
    end
    
    def before_update(record)
      puts "LeapfrogObserver#before_update : #{current_user_id}"
      record.updated_by = current_user_id
    end
end
