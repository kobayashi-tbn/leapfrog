# To change this template, choose Tools | Templates
# and open the template in the editor.

module Leapfrog
  module UserInfo
    def current_user_id
      Thread.current[:user_id]
    end

    def self.current_user_id=(user_id)
      Thread.current[:user_id] = user_id
    end
  end

  module Controller
    module Users
      def self.included(controller)
        controller.send :include, Leapfrog::Controller::InstanceMethods
        controller.send :before_filter, :set_current_user_id
      end
    end
 
    module InstanceMethods
      def set_current_user_id
        Leapfrog::UserInfo.current_user_id = session[:user_id] || -1
      end
    end
  end

  module Model
    module Observe
      def self.included(base)
        base.extend Leapfrog::Model::LfMacro
      end
    end

    module LfMacro
      def leapfrog_user_id
        self.send(:include, Leapfrog::UserInfo) unless self.include?(Leapfrog::UserInfo)
        self.send(:include, Leapfrog::Model::InstanceMethods) unless self.include?(Leapfrog::Model::InstanceMethods)

        before_create :set_user_id_to_created_by
        before_update :set_user_id_to_updated_by
      end
    end

    module InstanceMethods
      def set_user_id_to_created_by
        self.created_by = current_user_id
      end

      def set_user_id_to_updated_by
        self.updated_by = current_user_id
      end
    end
  end
end
