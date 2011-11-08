# To change this template, choose Tools | Templates
# and open the template in the editor.

module Leapfrog
  module UserInfo
    USERSTAMP_MAP = {:id => :user_id, :name => :username}
    
    def current_user_id
#      Thread.current[USERSTAMP_KEYS[:id]]
      current_user(USERSTAMP_MAP[:id])
    end

    def self.current_user_id=(user_id)
#      Thread.current[USERSTAMP_KEYS[:id]] = user_id
      Leapfrog::UserInfo.current_user = {USERSTAMP_MAP[:id] => user_id}
    end

    def current_user(key)
      Thread.current[key]
    end

    def self.current_user=(h)
      h.each do |key, user|
        Thread.current[key] = user
      end
    end

  end

  module Controller
    module Users
      def self.included(controller)
        controller.send :include, Leapfrog::Controller::InstanceMethods
        #controller.send :before_filter, :set_current_user_id
        controller.send :before_filter, :set_current_user
      end
    end
 
    module InstanceMethods
      def set_current_user(*args)
#        Leapfrog::UserInfo.current_user_id = session[:user_id] || -1

        users = {}
        Leapfrog::UserInfo::USERSTAMP_MAP.each do |k, v|
          users[v] = session[v]
        end

        Leapfrog::UserInfo.current_user = users
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
#        self.send(:include, Leapfrog::UserInfo) unless self.include?(Leapfrog::UserInfo)
#        self.send(:include, Leapfrog::Model::InstanceMethods) unless self.include?(Leapfrog::Model::InstanceMethods)
#
#        before_create :set_user_id_to_created_by
#        before_update :set_user_id_to_updated_by
        leapfrog :user_id
      end

      def leapfrog(key)
        self.send(:include, Leapfrog::UserInfo) unless self.include?(Leapfrog::UserInfo)
        self.send(:include, Leapfrog::Model::InstanceMethods) unless self.include?(Leapfrog::Model::InstanceMethods)

        before_create do |model|
          model.send(:set_user_to_created_by, key)
        end
        before_update do |model|
          model.send(:set_user_to_updated_by, key)
        end
      end
    end

    module InstanceMethods
#      def set_user_id_to_created_by
#        self.created_by = current_user_id
#      end
#
#      def set_user_id_to_updated_by
#        self.updated_by = current_user_id
#      end

      def set_user_to_created_by(key)
        self.created_by = current_user(key)
        self.updated_by = current_user(key)
      end

      def set_user_to_updated_by(key)
        self.updated_by = current_user(key)
      end
    end
  end
end
