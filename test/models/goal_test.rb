require "test_helper"

class GoalTest < ActiveSupport::TestCase

  def setup
    @time_now = Date.new
    @user = User.create
    @goal = Goal.create(user_id:@user.id, target:2, period:3, period_type:'month', start_date:@time_now)
  end

  def teardown
    User.destroy_all
    Goal.destroy_all
  end

  def test_its_attributes
    assert_equal @user.id, @goal.user_id
    assert_equal 2, @goal.target
    assert_equal 3, @goal.period
    assert_equal 'month', @goal.period_type
    assert_equal @time_now, @goal.start_date
  end


end
