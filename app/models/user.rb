class User < ApplicationRecord
  has_secure_password

  has_many :teams, class_name: "Team", foreign_key: "coach_id"
  has_many :leagues, class_name: "League", foreign_key: "official_id"
  has_many :center_referee, class_name: "Fixture", foreign_key: "center_referee_id"
  has_many :right_side_referee, class_name: "Fixture", foreign_key: "right_side_referee_id"
  has_many :left_side_referee, class_name: "Fixture", foreign_key: "left_side_referee_id"
  has_many :favourites
  
  belongs_to :role, optional: true

  validates_length_of       :password,
                            maximum: 72, minimum: 8,
                            allow_nil: true, allow_blank: false

  validates_confirmation_of :password,
                            allow_nil: true, allow_blank: false

  validates :username,
            uniqueness: { case_sensitive: false },
            presence: true, allow_blank: false

  validates :email,
            uniqueness: { case_sensitive: false },
            presence: true, allow_blank: false

  before_create :confirmation_token

  scope :get_all_referees, -> {includes(:role).where(roles: {name: 'Referee'})}
  scope :get_all_coaches, -> {includes(:role).where(roles: {name: 'Coach'})}
  scope :get_all_officials, -> {includes(:role).where(roles: {name: 'Official'})}

  def self.search(search_value)
    self.where("LOWER(username) LIKE ?", "%#{search_value.downcase}%")
  end

  def to_token_payload
    {
      sub: id,
      email: email,
      username: username,
      role: self.role.name,
      email_confirmed: email_confirmed
    }
  end

  def admin?
    role.name == "Admin"
  end

  def referee?
    role.name == "Referee"
  end

  def sponsor?
    role.name == "Sponsor"
  end

  def official?
    role.name == "Official"
  end

  def user?
    role.name == "User"
  end

  def coach?
    role.name == "Coach"
  end

  def player?
    role.name == "Player"
  end

  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end

  def account_deactivation_warning!
    transaction do
      DeactivateAccountMailer.deactivate_account(self).deliver_now
      update!(email_reminder_sent: true)
    end
  end
end
