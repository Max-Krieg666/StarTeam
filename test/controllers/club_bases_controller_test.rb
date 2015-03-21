require 'test_helper'

class ClubBasesControllerTest < ActionController::TestCase
  setup do
    @club_basis = club_bases(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:club_bases)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create club_basis" do
    assert_difference('ClubBase.count') do
      post :create, club_basis: { capacity: @club_basis.capacity, experience_up: @club_basis.experience_up, level: @club_basis.level, owner: @club_basis.owner, title: @club_basis.title, training_fields: @club_basis.training_fields }
    end

    assert_redirected_to club_basis_path(assigns(:club_basis))
  end

  test "should show club_basis" do
    get :show, id: @club_basis
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @club_basis
    assert_response :success
  end

  test "should update club_basis" do
    patch :update, id: @club_basis, club_basis: { capacity: @club_basis.capacity, experience_up: @club_basis.experience_up, level: @club_basis.level, owner: @club_basis.owner, title: @club_basis.title, training_fields: @club_basis.training_fields }
    assert_redirected_to club_basis_path(assigns(:club_basis))
  end

  test "should destroy club_basis" do
    assert_difference('ClubBase.count', -1) do
      delete :destroy, id: @club_basis
    end

    assert_redirected_to club_bases_path
  end
end
