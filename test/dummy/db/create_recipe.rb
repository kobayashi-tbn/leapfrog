class CreateRecipe < ActiveRecord::Migration
  def self.up
    create_table :dummy_recipes, :force => true do |t|
      t.string :foo
      t.string :bar
      t.integer :book_id

      t.timestamps
      t.userstamps
    end
  end

  def self.down
    drop_table :dummy_recipes
  end
end
