class CountriesController < ApplicationController
  before_action :check_user
  before_action :set_country, except: [:index, :create, :new]
  before_action :admin_permission, except: [:index, :show]

  def index
    @countries = Country.page(params[:page]).order(:title)
  end

  def show
    @users = User.includes(:country).where(country_id: @country.id).page(params[:users_page])
    @players = Player.includes(:country).where(country_id: @country.id, state: 0).order(:name, :position1).page(params[:players_page])
    @players_in_teams = Player.includes(:country).where(country_id: @country.id, state: 1).order(:name, :position1).page(params[:players_in_teams_page])
  end

  def new
    @country = Country.new
  end

  def edit; end

  def create
    @country = Country.new(country_params)

    respond_to do |format|
      if @country.save
        format.html { redirect_to @country, notice: I18n.t('flash.countries.created') }
        format.json { render :show, status: :created, location: @country }
      else
        format.html { render :new }
        format.json { render json: @country.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @country.update(country_params)
        format.html { redirect_to @country, notice: I18n.t('flash.countries.edited') }
        format.json { render :show, status: :ok, location: @country }
      else
        format.html { render :edit }
        format.json { render json: @country.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @country.destroy
    respond_to do |format|
      format.html { redirect_to countries_url, notice: I18n.t('flash.countries.destroyed') }
      format.json { head :no_content }
    end
  end

  private

  def set_country
    @country = Country.find(params[:id])
  end

  def country_params
    params.require(:country).permit(:title, :flag, :title_en)
  end
end
