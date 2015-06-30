class HomeController < ApplicationController

  def index
    redirect_to users_path if user_signed_in? and current_user.github_connected?
  end

end
