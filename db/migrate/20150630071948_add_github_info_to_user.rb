class AddGithubInfoToUser < ActiveRecord::Migration
  def change
    add_column :users, :github_email, :string
    add_column :users, :github_id, :integer
    add_column :users, :github_token, :string
    add_column :users, :github_login, :string
    add_column :users, :github_auth_hash, :text
  end
end
