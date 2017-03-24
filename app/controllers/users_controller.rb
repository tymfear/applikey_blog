class UsersController < ApplicationController
  before_action :load_user, only: %i(show edit update)
  before_action :authorize, only: %i(show edit update)
  before_action :check_current_user, only: %i(new create)

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.create user_params

    return render :new if @user.errors.any?

    redirect_to articles_path, notice: t('success.create', model: 'User')
    session[:user_id] = @user.id
  end

  def update
    @user.update user_params

    return render :edit if @user.errors.any?

    redirect_to @user, notice: t('success.update', model: 'User')
  end

  private
  def load_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user)
      .permit %i(username email password password_confirmation avatar)
  end
end
