class Search
  include ActiveModel::Model
  attr_accessor :query, :current_user_team,
                :country_id, :name,
                :position1, :skill_level, :talent, :age,
                :price, :available_for_buying

  def initialize(params = {})
    super(params)
  end

  def apply_search
    @query = Player.free_agent
    countries_search
    name_search
    position_search
    skill_level_search
    talent_search
    price_search
    age_search
    available_for_buying_search
  end

  def countries_search
    @query = @query.where(country_id: country_id) if country_id.present?
    @query
  end

  def name_search
    @query = @query.where('name LIKE ?', '%' + name + '%') if name.present?
    @query
  end

  def position_search
    return @query if position1.blank?

    @query = @query.where(position1: Player::POSITIONS.find_index(position1.to_sym))
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

  def price_search
    @query = @query.where('price > ?', price) if price.present?
    @query
  end

  def age_search
    @query = @query.where('age > ?', age) if age.present?
    @query
  end

  def available_for_buying_search
    @query = @query.where('price <= ?', @current_user_team.budget) if available_for_buying == 'true'
    @query
  end
end
