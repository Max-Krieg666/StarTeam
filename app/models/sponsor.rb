class Sponsor < ActiveRecord::Base
  belongs_to :team

  validates :title, presence: true, uniqueness: true, length: { maximum: 30 }
  validates :specialization, presence: true, length: { maximum: 100 }
  validates :loyalty_factor, presence: true, numericality: { greater_than: -5.0 }
  validates :cost_of_full_stake, presence: true
  validates :win_prize, presence: true, numericality: { greater_than: 100.0 }
  validates :draw_prize, presence: true, numericality: { greater_than: 100.0 }
  validates :lost_prize, presence: true, numericality: { greater_than: 100.0 }

  def create_rand
  	#TODO дописать!
  	# Faker::Company.name
  	# sp = Sponsor.new(title: "Sponsor-Test#{t + 1}",
   #                     specialization: "SpezTest#{rand(555) - rand(300)}",
   #                     loyalty_factor: 1.0,
   #                     cost_of_full_stake: rand(10000000) + 100000)
   #    sp.win_prize = sp.cost_of_full_stake / 1000.0
   #    sp.draw_prize = sp.cost_of_full_stake / 2000.0
   #    sp.lost_prize = sp.cost_of_full_stake / 8000.0
   #    sp.save!
   #    print "#{t + 1} -> "
  end
end
