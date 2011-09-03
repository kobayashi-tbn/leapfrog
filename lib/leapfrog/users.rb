# To change this template, choose Tools | Templates
# and open the template in the editor.

module Leapfrog
  module UserInfo
    def current_user_id
      #puts Thread.current
      Thread.current[:user_id]
    end

    def self.current_user_id=(user_id)
      #puts Thread.current
      Thread.current[:user_id] = user_id
    end
  end

  module Controller
    module Users
      def self.included(controller)
        controller.extend Leapfrog::Controller::LfMacro
        controller.lf_users
      end
    end
  
    module LfMacro
      def lf_users
        self.send(:include, Leapfrog::UserInfo)
        self.send(:include, Leapfrog::Controller::InstanceMethods)

        before_filter :set_current_user_id
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

        puts "♦LfObserveMacro #{self}"
        self.send(:include, Leapfrog::UserInfo)
        self.send(:include, Leapfrog::Model::InstanceMethods)

        before_create :set_user_id_to_created_by
        before_update :set_user_id_to_updated_by

      end
    end

    module InstanceMethods
      def set_user_id_to_created_by
        #puts "LeapfrogObserver#before_create : #{current_user_id}"
        self.created_by = current_user_id
      end

      def set_user_id_to_updated_by
        #puts "LeapfrogObserver#before_update : #{current_user_id}"
        self.updated_by = current_user_id
      end
    end
  end
end
