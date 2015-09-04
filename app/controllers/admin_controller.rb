class AdminController < ApplicationController
  before_filter :authorize
  def index

  end

  private

  def authorize
    unless current_user && current_user.admin?
      flash[:error] = "You do not have sufficient permissions to view this page"
      redirect_to root_path
    end
  end

end
