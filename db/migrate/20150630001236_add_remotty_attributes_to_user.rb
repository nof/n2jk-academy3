class AddRemottyAttributesToUser < ActiveRecord::Migration
  def change
    add_column :users, :participation_id, :integer
    add_column :users, :room_id, :integer
    add_column :users, :token, :string
    add_column :users, :email, :string
    add_column :users, :icon_url, :string
    add_column :users, :auth_hash, :text
  end
end
