class RemindersController < ApplicationController
  def index
    @user = User.friendly.find(params[:user_id])
    @reminders = if current_user&.admin?
                   Reminder.joins(:user)
                           .where(users: { admin_id: current_user.id })
                           .where(reminders: { user_id: @user.id })
                           .order(created_at: :desc)
                           .page(params[:page])
                 else
                   Reminder
                     .where(user_id: current_user.id)
                     .order(created_at: :desc)
                     .page(params[:page])
                 end
  end
end
