class UserSessionsController < ApplicationController
  before_action :require_no_athentication, only: [:new, :create]
  before_action :require_athentication, only: :destroy

  def new
    @user_session = UserSession.new(session)
  end

  def create
    @user_session = UserSession.new(session, params[:user_session])
    if @user_session.authenticate!
      redirect_to root_path, notice: t('flash.notice.signed_in')
    else
      render action: :new
    end
  end

  def destroy
    user_session.destroy
    redirect_to root_path, notice: t('flash.notice.signed_out')
  end
end
