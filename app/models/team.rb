class Team < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper

  belongs_to :user, inverse_of: :team
  belongs_to :country, inverse_of: :teams
  has_one :sponsor, inverse_of: :team, dependent: :destroy
  has_one :stadium, inverse_of: :team, dependent: :destroy
  has_one :club_base, inverse_of: :team, dependent: :destroy
  has_many :players, inverse_of: :team
  has_many :transfers, inverse_of: :team, dependent: :destroy
  has_many :operations, inverse_of: :team, dependent: :destroy
  has_many :team_leagues, class_name: 'TeamLeague', dependent: :destroy
  has_many :team_cups, class_name: 'TeamCup', dependent: :destroy
  has_many :games, inverse_of: :team, dependent: :destroy

  before_destroy :free_all_players

  def basic_order
    players.order('basic desc, position1 asc, skill_level desc')
  end

  def to_param
    title.tr(' ', '+')
  end

  def self.find(input)
    return super if input =~ /\A[a-fA-F0-9]{8}(-[a-fA-F0-9]{4}){3}-[a-fA-F0-9]{12}\z/
    find_by_title(input.tr('+', ' '))
  end

  def find_by_title(input)
    find_by title: input
  end

  validates :country_id, presence: true
  validates :title, presence: true, uniqueness: true, length: { maximum: 24 },
            format: {
              with: /\A[-A-Za-z0-9_ ]+\z/,
              message: :incorrect,
              if: 'title.present?'
            }

  validates :budget, presence: true
  validates :fans, presence: true

  def active_leagues_list
    return nil unless team_leagues
    team_leagues.joins(:league).where('leagues.status != 2')
  end

  def active_cups_list
    return nil unless team_cups
    team_cups.joins(:cup).where('cups.status != 2')
  end

  def in_league?(league_id)
    !active_leagues_list.where(league_id: league_id).blank?
  end

  def in_cup?(cup_id)
    !active_cups_list.where(cup_id: cup_id).blank?
  end

  def next_game
    # first of next games
    next_games.first
  end

  def next_games
    # all next games
    games.where('starting_time > ?', Time.current).order(:starting_time)
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

  def power_11
    main_squad.pluck(:skill_level).inject(0, :+)
  end

  def power
    players.pluck(:skill_level).inject(0, :+)
  end

  def budget_to_currency
    number_to_currency(budget, precision: 3, locale: :en)
  end

  def low_budget?(cost)
    budget < cost
  end

  def low_squad?
    squad_size < 15
  end

  private

  def free_all_players
    all_players = Player.where(team_id: team.id)
    ids = all_players.pluck(&:id)

    Carreer.where(player_id: ids, active: true).update_all(active: false)
    all_players.update_all(Player::DEFAULT_VALUES)
  end
end
