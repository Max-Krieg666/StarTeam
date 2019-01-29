class User < ApplicationRecord
  has_secure_password

  has_one :team, inverse_of: :user
  belongs_to :country, inverse_of: :users
  has_many :notifications, inverse_of: :user

  accepts_nested_attributes_for :team

  def to_param
    login.tr(' ', '+')
  end

  def self.find(input)
    return super if input =~ /\A[a-fA-F0-9]{8}(-[a-fA-F0-9]{4}){3}-[a-fA-F0-9]{12}\z/
    find_by_login(input.tr('+', ' '))
  end

  def find_by_login(input)
    find_by login: input
  end

  cattr_reader :roles

  SEXES = %i[not_specified male female].freeze

  ROLES = %i[user moderator administrator].freeze

  enum sex: SEXES
  enum role: ROLES

  before_validation :login_and_email_strip, on: :save
  before_validation :set_default_role, :check_bday

  validates :login,
            presence: true,
            length: { minimum: 3, maximum: 24, if: -> { login.present? } },
            uniqueness: true,
            exclusion: {
              in: %w[ADMIN AdMiN aDmIn Admin admin God god Root root]
            },
            format: {
              with: /\A[-A-Za-z0-9_ ]+\z/,
              message: :incorrect,
              if: -> { login.present? }
            }

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: {
              with: /\A[-\w.]+@([A-z0-9][-A-z0-9]+\.)+[A-z]{2,}\z/i,
              if: -> { email.present? }
            }

  validates :password, length: { minimum: 6, if: -> { password.present? } }
  validates :password_confirmation, presence: { on: :create }

  validates :country_id, presence: true

  validates :avatar,
            attachment_content_type: { content_type: /\Aimage\/.*\Z/ },
            attachment_size: { less_than: 1.megabytes },
            attachment_file_name: { matches: [/png\Z/, /gif\Z/, /jpe?g\Z/] }
  has_attached_file :avatar, styles: { medium: '300x300>', thumb: '100x100>' }

  def login_and_email_strip
    login.strip!
    email.strip!
  end

  def sex_name
    I18n.t("user.sex.#{sex}")
  end

  def role_name
    I18n.t("user.role.#{role}")
  end

  def moderator?
    role == 'moderator' || administrator?
  end

  def administrator?
    role == 'administrator'
  end

  def user?
    role == 'user'
  end

  def set_default_role
    self.role ||= 0
  end

  def check_bday
    return if birthday.blank? || birthday < Time.zone.now
    errors[:birthday] << I18n.t(:birthday_incorrect)
  end

  def unread_notifications
    notifications.where(viewed: false)
  end
end
