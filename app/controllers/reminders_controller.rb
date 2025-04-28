class RemindersController < ApplicationController
  before_action :move_to_signed_in
  before_action :set_user

  def new
    @reminder = Reminder.new
  end

  def create
    @reminder = @user.build_reminder(reminder_params)
    if @reminder.save
      redirect_to users_setting_path
    else
      render :new
    end
  end

  def edit
    @reminder = @user.reminder
  end

  def update
    @reminder = @user.reminder
    if @reminder.update(reminder_params)
      redirect_to users_setting_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = current_user
  end

  def reminder_params
    params.require(:reminder).permit(:mail_receiving_saturday, :mail_receiving_sunday)
  end

  def move_to_signed_in
    unless user_signed_in?
      # サインインしていないユーザーはトップページが表示される
      redirect_to root_path
    end
  end
end
