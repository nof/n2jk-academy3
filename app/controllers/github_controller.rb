class GithubController < ApplicationController
  def create
    auth_hash = request.env['omniauth.auth']
    current_user.update_github_account_with_auth_hash!(auth_hash)
    flash[:notice] = 'githubアカウントの認証に成功しました'
    redirect_to root_url
  end
end