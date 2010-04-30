class AddRolesToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :role, :text, :default => "Wikier"
  end

  def self.down
    remove_column :users, :role
  end
end
