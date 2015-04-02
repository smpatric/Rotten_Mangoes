class Admin::BaseController < ApplicationController

  before_action :enforce_admin_user

  def enforce_admin_user
    unless current_user && current_user.admin
      redirect_to root_url
    end
  end
end