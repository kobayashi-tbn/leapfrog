# To change this template, choose Tools | Templates
# and open the template in the editor.

module Leapfrog
  module Users
    def save_with_user(user)
      self.created_by = user if self.new_record?
      self.updated_by = user if !self.new_record?
      self.save
    end

    def update_with_user(params, user)
      self.updated_by = user
      self.update_attributes(params)
    end
  end
end
