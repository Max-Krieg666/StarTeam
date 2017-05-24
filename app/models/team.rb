class Team < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper
  
  belongs_to :user
  belongs_to :country
  has_one :sponsor
  has_one :stadium
  has_one :club_base
  has_many :players
  has_many :transfers
  has_many :operations
  has_many :teams_leagues
  has_many :teams_cups
  has_many :games

  def to_param
    title
  end

  def self.find(input)
    input.length == 36 ? super : find_by_title(input)
  end

  def find_by_title(input)
    where(title: input).first
  end

  validates :title, presence: true, uniqueness: true, length: { maximum: 24 }
  validates_format_of :title, with: /\A[-A-Za-z0-9_]+\z/, message: :incorrect
  validates :budget, presence: true
  validates :fans, presence: true

  def active_leagues_list
    teams_leagues.joins(:leagues).where('leagues.active = true')
  end

  def active_cups_list
    teams_cups.joins(:cups).where('cups.active = true')
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
