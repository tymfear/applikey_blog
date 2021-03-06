class SessionsController < ApplicationController
  before_action :check_current_user, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by_email(params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to articles_path, notice: t('success.signin', username: user.username)
    else
      redirect_to root_path,
                  flash: {
                      error: t('errors.signin_failed')
                  }
    end
  end

  def destroy
    session[:user_id] = nil

    redirect_to root_path
  end
end
