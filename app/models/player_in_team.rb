class PlayerInTeam < ActiveRecord::Base
  include Definer
  belongs_to :team
  belongs_to :country



  end


