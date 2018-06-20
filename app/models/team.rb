class Team < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper
  
  belongs_to :user, inverse_of: :team
  belongs_to :country, inverse_of: :teams
  has_one :sponsor, inverse_of: :team
  has_one :stadium, inverse_of: :team
  has_one :club_base, inverse_of: :team
  has_many :players, inverse_of: :team
  has_many :transfers, inverse_of: :team
  has_many :operations, inverse_of: :team
  has_many :team_leagues, class_name: 'TeamLeague'
  has_many :team_cups, class_name: 'TeamCup'
  has_many :games, inverse_of: :team

  def basic_order
    players.order('basic desc, position1 asc, skill_level desc')
  end

  def to_param
    title
  end

  def self.find(input)
    input.length == 36 ? super : find_by_title(input)
  end

  def find_by_title(input)
    where(title: input).first
  end

  validates :country_id, presence: true
  validates :title, presence: true, uniqueness: true, length: { maximum: 24 },
            format: { with: /\A[-A-Za-z0-9_]+\z/, message: :incorrect, if: 'title.present?' }

  validates :budget, presence: true
  validates :fans, presence: true

  def active_leagues_list
    return nil if !team_leagues
    team_leagues.joins(:league).where('leagues.status != 2')
  end

  def active_cups_list
    return nil if !team_cups
    team_cups.joins(:cup).where('cups.status != 2')
  end

  def is_in_league?(league_id)
    !active_leagues_list.where(league_id: league_id).blank?
  end

  def is_in_cup?(cup_id)
    !active_cups_list.where(cup_id: cup_id).blank?
  end

  def next_game
    # first of next games
    next_games.first
  end

  def next_games
    # all next games
    games.where('starting_time > ?', DateTime.current).order(:starting_time)
  end

  def captain
    players.order('skill_level desc').first
  end

  def squad_size
    players.size
  end

  def main_squad
    players.where(basic: true)
  end

  def reserve_squad
    players.where(basic: false)
  end

  def main_gk
    main_squad.gk.first
  end

  def reserve_gk
    reserve_squad.gk.first
  end

  def main_ld_cd_rd
    main_squad.where('position1 in (?)', [:ld, :cd, :rd])
  end

  def reserve_ld_cd_rd
    reserve_squad.where('position1 in (?)', [:ld, :cd, :rd])
  end

  def main_lm_cm_rm
    main_squad.where('position1 in (?)', [:lm, :cm, :rm])
  end

  def reserve_lm_cm_rm
    reserve_squad.where('position1 in (?)', [:lm, :cm, :rm])
  end

  def main_lf_cf_rf
    main_squad.where('position1 in (?)', [:lf, :cf, :rf])
  end

  def reserve_lf_cf_rf
    reserve_squad.where('position1 in (?)', [:lf, :cf, :rf])
  end

  def power_11
    main_squad.pluck(:skill_level).inject(0, :+)
  end

  def power
    players.pluck(:skill_level).inject(0, :+)
  end

  def budget_to_currency
    number_to_currency(budget, precision: 3, locale: :en)
  end

  def averages
    av_skills = 0
    av_age = 0
    av_price = 0
    av_tal = 0
    full_power = 0
    full_cost = 0
    players.each do |pl|
      av_skills += pl.skill_level
      av_age += pl.age
      av_price += pl.price
      av_tal += pl.talent
      full_power += pl.skill_level
      full_cost += pl.price
    end
    {
      av_skills: (av_skills / squad_size.to_f).round(2),
      av_age: (av_age / squad_size.to_f).round(2),
      av_price: number_to_currency((av_price / squad_size.to_f), locale: :en, precision: 3),
      av_tal: (av_tal / squad_size.to_f).round(1),
      full_power: full_power,
      full_cost: number_to_currency(full_cost, locale: :en, precision: 3)
    }
  end
end
