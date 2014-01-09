class GoalsController < ApplicationController
  def index
    @goals = Goal.where(user_id: current_user).to_a
  end
end
