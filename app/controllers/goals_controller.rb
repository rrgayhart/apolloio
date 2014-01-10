class GoalsController < ApplicationController

  def new
    @goal = Goal.new
  end

end
