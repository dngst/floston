# frozen_string_literal: true

class RemindersController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = User.friendly.find(params[:user_id])
    @pagy, @reminders = if current_user&.admin?
                          pagy(Reminder.joins(:user)
                                  .where(users: { admin_id: current_user.id })
                                  .where(reminders: { user_id: @user.id })
                                  .order(created_at: :desc))
                        else
                          pagy(Reminder
                            .where(user_id: current_user.id)
                            .order(created_at: :desc))
                        end
  end
end
