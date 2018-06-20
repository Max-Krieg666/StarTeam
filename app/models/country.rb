class Country < ActiveRecord::Base
  has_many :users, inverse_of: :country
  has_many :teams, inverse_of: :country
  has_many :players, inverse_of: :country
  has_many :cups, inverse_of: :country
  has_many :leagues, inverse_of: :country

  validates :flag, attachment_presence: true,
    attachment_content_type: { content_type: /\Aimage\/.*\Z/ },
    attachment_size: { less_than: 0.2.megabytes },
    attachment_file_name: { matches: [/png\Z/, /gif\Z/, /jpe?g\Z/] }
  has_attached_file :flag
  validates :title, presence: true, uniqueness: true
end
