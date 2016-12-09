class User < ActiveRecord::Base
  has_secure_password
  has_one :team
  belongs_to :country

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

  validates :avatar,
            attachment_content_type: { content_type: /\Aimage\/.*\Z/ },
            attachment_size: { less_than: 1.megabytes },
            attachment_file_name: { matches: [/png\Z/, /gif\Z/, /jpe?g\Z/] }
  has_attached_file :avatar, styles: { medium: '300x300>', thumb: '100x100>' }

  before_validation :set_default_role, :check_bday
  validates :password, length: { minimum: 6, if: 'password.present?' }, presence: { on: :create }
  validates :role, presence: true, inclusion: { in: 0...@@roles.size }
  validates :login, presence: true, length: { minimum: 3, maximum: 24 },
            uniqueness: true, exclusion: { in: %w(admin god root) }
  validates :email, presence: true, uniqueness: { case_sensitive: false },
            format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  def login_and_email_strip
    login.strip!
    email.strip!
  end

  def moderator?
    role == 1 || administrator?
  end

  def administrator?
    role == 2
  end

  def user?
    role.zero?
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
end
