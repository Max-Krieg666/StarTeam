class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable#, :omniauthable
  #TODO https://github.com/plataformatec/devise/wiki/How-To:-Allow-users-to-sign-in-using-their-username-or-email-address
  has_one :team
  belongs_to :country

  cattr_reader :roles

  validates :avatar,
            attachment_content_type: { content_type: /\Aimage\/.*\Z/ },
            attachment_size: { less_than: 1.megabytes },
            attachment_file_name: { matches: [/png\Z/, /gif\Z/, /jpe?g\Z/] }
  has_attached_file :avatar, styles: { medium: '300x300>', thumb: '100x100>' }
  @@roles = %w(Пользователь Модератор Администратор)

  before_validation :set_default_role, :check_bday
  validates_confirmation_of :password
  validates :role, presence: true, inclusion: { in: 0...@@roles.size }
  validates :login, presence: true, length: { minimum: 3, maximum: 24 },
            uniqueness: true, exclusion: { in: %w(admin god root) }
  validates :email, presence: true, uniqueness: { case_sensitive: false },
            format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  def role_name
    role && @@roles[role]
  end

  def moderator?
    role == 1 || administrator?
  end

  def administrator?
    role == 2
  end

  def user?
    role == 0
  end

  def set_default_role
    self.role ||= 0
  end

  def check_bday
    return if self.birthday.blank?
    self.errors[:birthday] << ' не существует!' if birthday > Time.now
  end

  def force_authenticate!(controller)
    controller.session[:user_id] = id
  end
end
