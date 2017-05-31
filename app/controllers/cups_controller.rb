class CupsController < ApplicationController
  before_action :check_user
  before_action :moderator_permission, only: [:new, :create, :edit, :update]
  before_action :admin_permission, only: [:destroy]
  before_action :set_cup, only: [:show, :edit, :update, :destroy]

  def index
  end

  def show
    @teams_in_cup = @cup.team_cups
  end

  def new
    @cup = Cup.new
  end

  def create
    @cup = Cup.new(cup_params)

    respond_to do |format|
      if @cup.save
        format.html { redirect_to @cup, notice: I18n.t('flash.cups.created') }
        format.json { render :show, status: :created, location: @cup }
      else
        format.html { render :new }
        format.json { render json: @cup.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @cup.update(country_params)
        format.html { redirect_to @cup, notice: I18n.t('flash.cups.edited') }
        format.json { render :show, status: :ok, location: @cup }
      else
        format.html { render :edit }
        format.json { render json: @cup.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @cup.team_cups.any?
      redirect_to @cup, error: I18n.t('flash.cups.cup_has_teams')
    else
      @cup.destroy
      respond_to do |format|
        format.html { redirect_to transfers_url, notice: I18n.t('flash.cups.destroyed') }
        format.json { head :no_content }
      end
    end
  end

  private
  
  def set_cup
    @cup = Cup.find(params[:id])
  end

  def cup_params
    params.require(:cup).permit(:title, :country_id)
  end
end
