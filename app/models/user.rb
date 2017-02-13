class User < ActiveRecord::Base
  has_secure_password
  has_one :team
  belongs_to :country
  has_many :notifications

  def to_param
    login
  end

  def self.find(input)
    input.length == 36 ? super : find_by_login(input)
  end

  def find_by_login(input)
    self.where(login: input).first
  end

  cattr_reader :roles

  enum sex: [
    :not_specified,
    :male,
    :female
  ]

  enum role: [
    :user,
    :moderator,
    :administrator
  ]

  before_validation :login_and_email_strip, on: :save
  before_validation :set_default_role, :check_bday

  validates :avatar,
            attachment_content_type: { content_type: /\Aimage\/.*\Z/ },
            attachment_size: { less_than: 1.megabytes },
            attachment_file_name: { matches: [/png\Z/, /gif\Z/, /jpe?g\Z/] }
  has_attached_file :avatar, styles: { medium: '300x300>', thumb: '100x100>' }

  validates :password, length: { minimum: 6, if: 'password.present?' }, presence: { on: :create }
  validates :login, presence: true, length: { minimum: 3, maximum: 24 },
            uniqueness: true, exclusion: { in: %w(ADMIN AdMiN aDmIn Admin admin God god Root root) }
  validates :email, presence: true, uniqueness: { case_sensitive: false },
            format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  validates_format_of :login, with: /\A[-A-Za-z0-9_]+\z/, message: :incorrect

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
    return if birthday.blank?
    errors[:birthday] << ' не существует!' if birthday > Time.zone.now
  end

  def force_authenticate!(controller)
    controller.session[:user_id] = id
  end

  def unread_notifications
    notifications.where(viewed: false)
  end
end
