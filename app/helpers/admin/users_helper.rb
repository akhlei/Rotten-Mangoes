module Admin::UsersHelper

  def not_admin_redirect
    redirect_to root_path, notice: "Get out! You must be an admin to view that page!"
  end
end
