class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :my_item?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authorize
    redirect_to root_path unless current_user
  end

  def check_current_user
    redirect_to current_user if current_user
  end

  def my_item?(record)
    return false unless record.respond_to? :user_id

    record.user_id == current_user.id
  end
end
