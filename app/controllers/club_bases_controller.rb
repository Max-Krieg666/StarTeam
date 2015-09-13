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
    @team = @club_basis.team
    @user = @team.user
  end

  # GET /club_bases/new
  def new
    @club_basis = ClubBase.new
    @club_basis.team_id = @team.id
  end

  # GET /club_bases/1/edit
  def edit
    team=Team.find(@club_basis.team_id)
    old_level=@club_basis.level
    old_tr=@club_basis.training_fields
    if !params[:level].blank? && params[:level]!="" && params[:level].to_i != old_level
      lvl=params[:level].to_i
      if lvl!=old_level+1
        flash[:danger]='Неправильный параметр уровня базы клуба!'
        redirect_to @club_basis
      elsif lvl>5
        flash[:danger]='База клуба имеет максимальный уровень!'
        redirect_to @club_basis
      else
        if old_level==1
          cost,exp,cap=50000,0.2,23
        elsif old_level==2
          cost,exp,cap=400000,0.4,26
        elsif old_level==3
          cost,exp,cap=1000000,0.75,30
        elsif old_level==4
          cost,exp,cap=2500000,1.0,35
        else
          flash[:danger]='Неправильное значение уровня базы клуба!'
          redirect_to @club_basis
        end
        if team.budget-cost<0
          flash[:danger]='На вашем счету недостаточно средств для улучшения базы клуба!'
          redirect_to @club_basis
        else
          team.budget-=cost
          team.save!
          @club_basis.update(level:lvl,experience_up:exp,capacity:cap)
          redirect_to @club_basis, notice: 'Уровень базы клуба успешно повышен.'
        end
      end
    elsif !params[:training_fields].blank? && params[:training_fields]!=""# && params[:training_fields].to_i != old_tr
      tlvl=params[:training_fields].to_i
      if tlvl!=old_tr+1
        flash[:danger]='Неправильный параметр уровня базы клуба!'
        redirect_to @club_basis
      elsif tlvl>5
        flash[:danger]='Максимальное количество тренировочных полей достигнуто!'
        redirect_to @club_basis
      else
        if old_tr==1
          cost,k=250000,1.2
        elsif old_tr==2
          cost,k=750000,1.5
        elsif old_tr==3
          cost,k=1500000,1.75
        elsif old_tr==4
          cost,k=3000000,2.0
        else
          flash[:danger]='Неправильное значение уровня базы клуба!'
          redirect_to @club_basis
        end
        if team.budget-cost<0
          flash[:danger]='На вашем счету недостаточно средств для улучшения уровня базы клуба!'
          redirect_to @club_basis
        else
          lev=@club_basis.level
          if lev==1
            exp=0.1
          elsif lev==2
            exp=0.2
          elsif lev==3
            exp=0.4
          elsif lev==4
            exp=0.75
          elsif lev==5
            exp=1.0
          end
          team.budget-=cost
          team.save!
          @club_basis.update!(training_fields:tlvl,experience_up:(exp*k).round(1))
          redirect_to @club_basis, notice: 'Уровень базы клуба успешно повышен.'
        end
      end
    else
      redirect_to @club_basis
    end
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
