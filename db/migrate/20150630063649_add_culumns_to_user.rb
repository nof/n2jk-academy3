class AddCulumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :level, :string
    add_column :users, :working_form, :string
    add_column :users, :last_talk, :datetime
  end
end
