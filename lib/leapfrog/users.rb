# To change this template, choose Tools | Templates
# and open the template in the editor.

module Leapfrog
  module UserInfo
    USERSTAMP_KEY_MAP = {:id => :user_id, :name => :username}

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
        controller.send :before_filter, :set_current_user
      end
    end
 
    module InstanceMethods
      def set_current_user(*args)

        # for devise
        if session['warden.user.user.key'] && session['warden.user.user.key'][1][0]
          session[:username] = session['warden.user.user.key'][1][0]
        end

        users = {}
        Leapfrog::UserInfo::USERSTAMP_KEY_MAP.each do |k, v|
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
        puts "[Warn] Method leapfrog_user_id is deprecated. Usage leapfrog(key) insted."
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
