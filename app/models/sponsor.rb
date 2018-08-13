class Sponsor < ActiveRecord::Base
  belongs_to :team, inverse_of: :sponsor

  validates :title, presence: true, length: { maximum: 30 }
  validates :loyalty_factor, presence: true, numericality: { greater_than: -5.0 }
  validates :cost_of_full_stake, presence: true
  validates :win_prize, presence: true, numericality: { greater_than: 100.0 }
  validates :draw_prize, presence: true, numericality: { greater_than: 100.0 }
  validates :lost_prize, presence: true, numericality: { greater_than: 100.0 }

  enum specialization: [
    :space_research,
    :computer_hardware,
    :computer_software,
    :computer_networking,
    :internet,
    :web_security,
    :semiconductors,
    :telecommunications,
    :law_practice,
    :management_consulting,
    :biotechnology,
    :medical_practice,
    :drugs_production,
    :pharmaceuticals,
    :veterinary,
    :medical_devices,
    :cosmetics,
    :apparel_and_fashion,
    :sporting_goods,
    :tobacco,
    :supermarkets,
    :electronics_production,
    :furniture,
    :retail,
    :entertainment,
    :gambling_and_casinos,
    :leisure_and_travel_and_tourism,
    :tour_agency,
    :restaurants,
    :alcohol,
    :film_studio,
    :broadcast_media,
    :art_studio,
    :hotels,
    :banking,
    :insurance,
    :financial_services,
    :real_estate,
    :investment_banking,
    :investment_management,
    :accounting,
    :construction,
    :building_materials,
    :architecture_and_planning,
    :civil_engineering,
    :airline,
    :automotive,
    :chemicals,
    :machinery,
    :mining_and_metals,
    :oil_and_energy,
    :shipbuilding,
    :textiles,
    :paper_and_forest_products,
    :railroad_manufacture,
    :scientific_researches,
    :weapon_production,
    :marketing,
    :advertising,
    :pr_agency,
    :newspapers,
    :publishing,
    :information_services,
    :environmental_services,
    :package_or_freight_delivery,
    :transportationg_or_trucking_or_railroad,
    :maritime,
    :information_technology_and_services,
    :design,
    :program_development,
    :computer_games,
    :nanotechnology,
    :record_label,
    :logistics_and_supply_chain,
    :computer_security,
    :outsourcing,
    :health_wellness_and_fitness,
    :media_production,
    :animation,
    :business_supplies_and_equipment,
    :luxury_goods_and_jewelry,
    :industrial_automation
  ]

  def self.create_rand(team_id)
    spec_num = SecureRandom.random_number(Sponsor.specializations.size)
    sp = self.new(
      title: Sponsor.random_title,
      team_id: team_id,
      specialization: Sponsor.specializations.values[spec_num],
      cost_of_full_stake: SecureRandom.random_number(8000000..25000000).to_f
    )
    sp.lost_prize = (sp.cost_of_full_stake / 8000.0).round(3)
    sp.draw_prize = (sp.lost_prize * 4).round(3)
    sp.win_prize = (sp.draw_prize * 2).round(3)
    sp.save!
    sp
  end

  def self.random_title
    file = YAML.load_file(
      Rails.root.join('lib', 'lastnames', 'english_lastnames.yml')
    )
    title = file[SecureRandom.random_number(file.size)]['lastname']
    random = rand(5)
    case random
    when 0
      title
    when 1
      title + ' Inc'
    when 2
      title + ' Ent.'
    when 3
      title + ' LLC'
    else
      title + ' Group'
    end
  end
end
