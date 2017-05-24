class LeaguesController < ApplicationController
  before_action :check_user
  before_action :moderator_permission, only: [:new, :create, :edit, :update]
  before_action :admin_permission, only: [:destroy]
  before_action :set_league, only: [:show, :edit, :update, :destroy]

  def index
  end

  def show
    @teams_in_league = @league.teams_leagues
  end

  def new
    @league = League.new
  end

  def create
    @league = League.new(league_params)

    respond_to do |format|
      if @league.save
        format.html { redirect_to @league, notice: I18n.t('flash.leagues.created') }
        format.json { render :show, status: :created, location: @league }
      else
        format.html { render :new }
        format.json { render json: @league.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @league.update(country_params)
        format.html { redirect_to @league, notice: I18n.t('flash.leagues.edited') }
        format.json { render :show, status: :ok, location: @league }
      else
        format.html { render :edit }
        format.json { render json: @league.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @league.teams_leagues.any?
      redirect_to @league, error: I18n.t('flash.leagues.league_has_teams')
    else
      @league.destroy
      respond_to do |format|
        format.html { redirect_to transfers_url, notice: I18n.t('flash.leagues.destroyed') }
        format.json { head :no_content }
      end
    end
  end

  private
  
  def set_league
    @league = League.find(params[:id])
  end

  def league_params
    params.require(:league).permit(:title, :country_id)
  end
end