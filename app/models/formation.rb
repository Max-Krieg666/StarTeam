# == Schema Information
#
# Table name: formations
#
#  id     :uuid             not null, primary key
#  name   :string
#  schema :string
#

class Formation < ApplicationRecord
  has_many :teams, inverse_of: :formation

  DEFAULT_POSITIONS_COUNTER = {
    'gk': 0,
    'ld': 0,
    'cd': 0,
    'rd': 0,
    'lm': 0,
    'cm': 0,
    'rm': 0,
    'lf': 0,
    'cf': 0,
    'rf': 0
  }.freeze

  def with_reserve_players_before_generation
    positions_count = DEFAULT_POSITIONS_COUNTER.dup
    positions_count.each do |pos, _|
      positions_count[pos] = number_of_players_for_position(pos)
    end
    boost_players_per_position(positions_count)
  end

  def number_of_players_for_position(position)
    schema.scan(position).size
  end

  def boost_players_per_position(positions_count)
    zero_players_per_pos = []
    one_player_per_pos = []
    two_players_per_pos = []
    three_players_per_pos = []

    positions_count.each do |pos, count|
      case count
      when 1
        one_player_per_pos << { pos => count }
      when 2
        two_players_per_pos << { pos => count }
      when 3
        three_players_per_pos << { pos => count }
      else # 0
        zero_players_per_pos << { pos => count }
      end
    end

    unallocated_players = 7
    three_players_per_pos.each do |pos, val|
      value_boost = rand(1..2)
      positions_count[pos] = val + value_boost
      unallocated_players -= value_boost
    end
    two_players_per_pos.each do |pos, val|
      break if unallocated_players.zero?
      value_boost = 1
      positions_count[pos] = val + value_boost
      unallocated_players -= value_boost
    end
    one_player_per_pos.each do |pos, val|
      break if unallocated_players.zero?
      value_boost = 1
      positions_count[pos] = val + value_boost
      unallocated_players -= value_boost
    end
    positions_count
  end
end
