class ClubBasesController < ApplicationController
  before_action :set_club_basis, only: [:show, :edit, :update, :destroy]
  before_action :set_team, only: :new
  before_action :admin_permission, only: :destroy

  # GET /club_bases
  # GET /club_bases.json
  def index
    @club_bases = ClubBase.page(params[:page])
  end

  # GET /club_bases/1
  # GET /club_bases/1.json
  def show
    @team=Team.find(@club_basis.team_id)
    @user=User.find(@team.user_id)
  end

  # GET /club_bases/new
  def new
    @club_basis = ClubBase.new
    @club_basis.team_id=@team.id
  end

  # GET /club_bases/1/edit
  def edit
  end

  # POST /club_bases
  # POST /club_bases.json
  def create
    hash=params
    other_hash={"club_basis"=>params[:club_base]}
    hash.delete(hash.keys[2])
    hash.update(other_hash)
    @club_basis = ClubBase.new(club_basis_params)
    @team=Team.find(club_basis_params[:team_id])
    @club_basis.team=@team
    #respond_to do |format|
      if @club_basis.save
        @team.club_basis_id=@club_basis.id
        @team.save!
        redirect_to @club_basis, notice: 'База успешно создана.'
        #format.html { redirect_to @club_basis, notice: 'Club base was successfully created.' }
        #format.json { render :show, status: :created, location: @club_basis }
      else
        render :new
        #format.html { render :new }
        #format.json { render json: @club_basis.errors, status: :unprocessable_entity }
      end
    #end
  end

  # PATCH/PUT /club_bases/1
  # PATCH/PUT /club_bases/1.json
  def update
    #respond_to do |format|
      if @club_basis.update(club_basis_params)
        redirect_to @club_basis, notice: 'База успешно изменена.'
        #format.html { redirect_to @club_basis, notice: 'Club base was successfully updated.' }
        #format.json { render :show, status: :ok, location: @club_basis }
      else
        render :edit
        #format.html { render :edit }
        #format.json { render json: @club_basis.errors, status: :unprocessable_entity }
      end
    #end
  end

  # DELETE /club_bases/1
  # DELETE /club_bases/1.json
  def destroy
    @club_basis.destroy
    redirect_to club_bases_url, notice: 'База успешно удалена.'
    #respond_to do |format|
      #format.html { redirect_to club_bases_url, notice: 'Club base was successfully destroyed.' }
      #format.json { head :no_content }
    #end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_club_basis
      @club_basis = ClubBase.find(params[:id])
    end

    def set_team
      @team = Team.find(params[:team_id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def club_basis_params
      params.require(:club_basis).permit(:title,:team_id)#, :level, :capacity, :training_fields, :experience_up, :team_id)
    end
end
