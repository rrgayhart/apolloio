require "test_helper"

class GoalTest < ActiveSupport::TestCase

  def setup
    @time_now = Date.new
    @user = User.create
    @goal = Goal.create(user_id:@user.id, target:2, period_type:'months', start_date:@time_now)
    @valid_goal = Goal.new(user_id:@user.id, target:1, period_type:'months', start_date:@time_now, pledge: "My goal is to reach 2 commit every 3 months")
  end

  def teardown
    User.destroy_all
    Goal.destroy_all
  end

  def test_it_activates
    assert_equal true, @goal.active
    @goal.active = false
    assert_equal false, @goal.active
  end

  def test_validation_for_target
    assert @valid_goal.valid?
    @valid_goal.target = -1
    refute @valid_goal.valid?
    @valid_goal.target = nil
    refute @valid_goal.valid?
  end

  def test_validation_for_period_type
    ["days","weeks","months"].each do |type|
      @valid_goal.period_type = type
      assert @valid_goal.valid?
    end
    @valid_goal.period_type = "jokes"
    refute @valid_goal.valid?
    @valid_goal.period_type = nil
    refute @valid_goal.valid?
  end

  def test_start_date_after_create
    current_date = DateTime.now.to_date
    goal = Goal.create(user_id:@user.id, target: 2, period_type: 'months', start_date: '', pledge: "the pledge")
    assert_equal current_date, goal.start_date
  end
end
