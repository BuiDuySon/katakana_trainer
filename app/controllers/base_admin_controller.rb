class BaseAdminController < ApplicationController

  before_filter :require_admin!

  private
  def require_admin!
    return redirect_to root_path unless current_user && current_user.admin?
  end

end
