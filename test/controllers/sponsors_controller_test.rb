require 'test_helper'

class SponsorsControllerTest < ActionController::TestCase
  setup do
    @sponsor = sponsors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sponsors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sponsor" do
    assert_difference('Sponsor.count') do
      post :create, sponsor: { cost_of_full_stake: @sponsor.cost_of_full_stake, draw_prize: @sponsor.draw_prize, lost_prize: @sponsor.lost_prize, loyalty_factor: @sponsor.loyalty_factor, specialization: @sponsor.specialization, sponsorship: @sponsor.sponsorship, title: @sponsor.title, win_prize: @sponsor.win_prize }
    end

    assert_redirected_to sponsor_path(assigns(:sponsor))
  end

  test "should show sponsor" do
    get :show, id: @sponsor
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sponsor
    assert_response :success
  end

  test "should update sponsor" do
    patch :update, id: @sponsor, sponsor: { cost_of_full_stake: @sponsor.cost_of_full_stake, draw_prize: @sponsor.draw_prize, lost_prize: @sponsor.lost_prize, loyalty_factor: @sponsor.loyalty_factor, specialization: @sponsor.specialization, sponsorship: @sponsor.sponsorship, title: @sponsor.title, win_prize: @sponsor.win_prize }
    assert_redirected_to sponsor_path(assigns(:sponsor))
  end

  test "should destroy sponsor" do
    assert_difference('Sponsor.count', -1) do
      delete :destroy, id: @sponsor
    end

    assert_redirected_to sponsors_path
  end
end
