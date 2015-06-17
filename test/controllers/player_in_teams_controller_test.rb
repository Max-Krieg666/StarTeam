require 'test_helper'

class PlayerInTeamsControllerTest < ActionController::TestCase
  setup do
    @player_in_team = player_in_teams(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:player_in_teams)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create player_in_team" do
    assert_difference('PlayerInTeam.count') do
      post :create, player_in_team: { all_autogoals: @player_in_team.all_autogoals, all_games: @player_in_team.all_games, all_goals: @player_in_team.all_goals, all_red_cards: @player_in_team.all_red_cards, all_yellow_cards: @player_in_team.all_yellow_cards, can_play: @player_in_team.can_play, injured: @player_in_team.injured, num_sp_s1: @player_in_team.num_sp_s1, num_sp_s2: @player_in_team.num_sp_s2, num_sp_s3: @player_in_team.num_sp_s3, number: @player_in_team.number, season_autogoals: @player_in_team.season_autogoals, season_games: @player_in_team.season_games, season_goals: @player_in_team.season_goals, season_red_cards: @player_in_team.season_red_cards, season_yellow_cards: @player_in_team.season_yellow_cards, special_skill1: @player_in_team.special_skill1, special_skill2: @player_in_team.special_skill2, special_skill3: @player_in_team.special_skill3, status: @player_in_team.status }
    end

    assert_redirected_to player_in_team_path(assigns(:player_in_team))
  end

  test "should show player_in_team" do
    get :show, id: @player_in_team
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @player_in_team
    assert_response :success
  end

  test "should update player_in_team" do
    patch :update, id: @player_in_team, player_in_team: { all_autogoals: @player_in_team.all_autogoals, all_games: @player_in_team.all_games, all_goals: @player_in_team.all_goals, all_red_cards: @player_in_team.all_red_cards, all_yellow_cards: @player_in_team.all_yellow_cards, can_play: @player_in_team.can_play, injured: @player_in_team.injured, num_sp_s1: @player_in_team.num_sp_s1, num_sp_s2: @player_in_team.num_sp_s2, num_sp_s3: @player_in_team.num_sp_s3, number: @player_in_team.number, season_autogoals: @player_in_team.season_autogoals, season_games: @player_in_team.season_games, season_goals: @player_in_team.season_goals, season_red_cards: @player_in_team.season_red_cards, season_yellow_cards: @player_in_team.season_yellow_cards, special_skill1: @player_in_team.special_skill1, special_skill2: @player_in_team.special_skill2, special_skill3: @player_in_team.special_skill3, status: @player_in_team.status }
    assert_redirected_to player_in_team_path(assigns(:player_in_team))
  end

  test "should destroy player_in_team" do
    assert_difference('PlayerInTeam.count', -1) do
      delete :destroy, id: @player_in_team
    end

    assert_redirected_to player_in_teams_path
  end
end
