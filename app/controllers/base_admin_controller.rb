class BaseAdminController < ApplicationController

  before_filter :require_admin!

  private
  def require_admin!
    return root_path unless current_user
    true #TODO: implement
  end

end
