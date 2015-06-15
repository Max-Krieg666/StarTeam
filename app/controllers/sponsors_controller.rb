class SponsorsController < ApplicationController
  before_action :set_sponsor, only: [:show, :edit, :update, :destroy]
  before_action :admin_permission, except: [:show]

  # GET /sponsors
  # GET /sponsors.json
  def index
    @sponsors = Sponsor.page(params[:page])
  end

  # GET /sponsors/1
  # GET /sponsors/1.json
  def show
  end

  # GET /sponsors/new
  def new
    @sponsor = Sponsor.new
  end

  # GET /sponsors/1/edit
  def edit
  end

  # POST /sponsors
  # POST /sponsors.json
  def create
    @sponsor = Sponsor.new(sponsor_params)
    sp=sponsor_params[:cost_of_full_stake]
    @sponsor.win_prize=sp/1000.0
    @sponsor.draw_prize=sp/2000.0
    @sponsor.lost_prize=sp/8000.0
    #respond_to do |format|
      if @sponsor.save
        #format.html { redirect_to @sponsor, notice: 'Спонсор успешно создан.' }
        #format.json { render :show, status: :created, location: @sponsor }
        redirect_to @sponsor, notice: 'Спонсор успешно создан.'
      else
        #format.html { render :new }
        #format.json { render json: @sponsor.errors, status: :unprocessable_entity }
        render :new
      end
    #end
  end

  # PATCH/PUT /sponsors/1
  # PATCH/PUT /sponsors/1.json
  def update
    #respond_to do |format|
      if @sponsor.update(sponsor_params)
        #format.html { redirect_to @sponsor, notice: 'Спонсор успешно изменен.' }
        #format.json { render :show, status: :ok, location: @sponsor }
        redirect_to @sponsor, notice: 'Спонсор успешно изменен.'
      else
        #format.html { render :edit }
        #format.json { render json: @sponsor.errors, status: :unprocessable_entity }
        render :edit
      end
    #end
  end

  # DELETE /sponsors/1
  # DELETE /sponsors/1.json
  def destroy
    @sponsor.destroy
    #respond_to do |format|
      #format.html { redirect_to sponsors_url, notice: 'Спонсор успешно удален.' }
      #format.json { head :no_content }
    redirect_to sponsors_url, notice: 'Спонсор успешно удален.'
    #end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sponsor
      @sponsor = Sponsor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sponsor_params
      params.require(:sponsor).permit(:title, :specialization, :loyalty_factor, :cost_of_full_stake)#, :win_prize, :draw_prize, :lost_prize)
    end
end
