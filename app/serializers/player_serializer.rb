# == Schema Information
#
# Table name: players
#
#  id                    :uuid             not null, primary key
#  name                  :string(50)       not null
#  country_id            :bigint(8)
#  position1             :integer          not null
#  position2             :integer
#  efficienty            :float            default(1.0)
#  talent                :integer          not null
#  age                   :integer          not null
#  skill_level           :integer          not null
#  price                 :float            not null
#  state                 :integer          default("free_agent")
#  training_points       :integer          default(0)
#  tackling              :integer          default(0)
#  marking               :integer          default(0)
#  positioning           :integer          default(0)
#  heading               :integer          default(0)
#  pressure              :integer          default(0)
#  shot_accuracy         :integer          default(0)
#  shot_power            :integer          default(0)
#  dribbling             :integer          default(0)
#  passing               :integer          default(0)
#  carport               :integer          default(0)
#  speed                 :integer          default(0)
#  endurance             :integer          default(0)
#  reaction              :integer          default(0)
#  aggression            :integer          default(0)
#  creativity            :integer          default(0)
#  team_id               :uuid
#  special_skill1        :string(2)
#  num_sp_s1             :integer
#  special_skill2        :string(2)
#  num_sp_s2             :integer
#  special_skill3        :string(2)
#  num_sp_s3             :integer
#  number                :integer
#  season_games          :integer          default(0)
#  all_games             :integer          default(0)
#  season_goals          :integer          default(0)
#  all_goals             :integer          default(0)
#  season_passes         :integer          default(0)
#  all_passes            :integer          default(0)
#  season_conceded_goals :integer          default(0)
#  all_conceded_goals    :integer          default(0)
#  season_autogoals      :integer          default(0)
#  all_autogoals         :integer          default(0)
#  season_yellow_cards   :integer          default(0)
#  all_yellow_cards      :integer          default(0)
#  season_red_cards      :integer          default(0)
#  all_red_cards         :integer          default(0)
#  status                :integer          default("active")
#  basic                 :boolean          default(FALSE)
#  can_play              :boolean          default(TRUE)
#  games_missed          :integer          default(0)
#  injured               :boolean          default(FALSE)
#  captain               :boolean
#  morale                :integer          default(5)
#  physical_condition    :float            default(1.0)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  real_position         :integer
#

class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :name, :position1, :position2, :real_position,
             :efficienty, :talent, :age, :skill_level, :state,
             :injured, :can_play
end
