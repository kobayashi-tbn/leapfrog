# To change this template, choose Tools | Templates
# and open the template in the editor.

class AddUserstampsToPost < ActiveRecord::Migration
  def self.up
    add_userstamps :dummy_posts, :type => :string
  end

  def self.down
    remove_userstamps :dummy_posts
  end
end
