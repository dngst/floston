class RemindersController < ApplicationController
  def index
    @reminders = if current_user&.admin?
                  Reminder.joins(:user).where(users: { admin_id: current_user.id }).order(created_at: :desc).page(params[:page])
                else
                  Reminder.where(user_id: current_user.id).order(created_at: :desc).page(params[:page])
                end
  end
end
