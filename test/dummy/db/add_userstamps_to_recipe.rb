# To change this template, choose Tools | Templates
# and open the template in the editor.

class AddUserstampsToRecipe < ActiveRecord::Migration
  def self.up
    add_userstamps :dummy_recipes
  end

  def self.down
    remove_userstamps :dummy_recipes
  end
end
