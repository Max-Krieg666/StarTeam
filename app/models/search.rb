class Search
  include ActiveModel::Model
  attr_accessor :query, :country_id, :name, :position1, :skill_level, :talent, :age

  def initialize(params = {})
    super(params)
  end

  def apply_search
    @query = Player.free_agent
    countries_search
    name_search
    position_inspect
    position_search
    skill_level_search
    talent_search
    age_search
  end

  def countries_search
    @query = @query.where(country_id: country_id) if country_id.present?
    @query
  end

  def name_search
    @query = @query.where('name LIKE ?', '%' + name + '%') if name.present?
    @query
  end

  def position_inspect
    position1.blank? || Player::POSITIONS.find_index(position1)
  end

  def position_search
    @query = @query.where(position1: Player::POSITIONS.find_index(position1)) if position1.present?
    @query
  end

  def skill_level_search
    @query = @query.where('skill_level > ?', skill_level) if skill_level.present?
    @query
  end

  def talent_search
    @query = @query.where('talent > ?', talent) if talent.present?
    @query
  end

  def age_search
    @query = @query.where('age > ?', age) if age.present?
    @query
  end
end
