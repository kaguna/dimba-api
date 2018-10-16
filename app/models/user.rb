class User < ApplicationRecord
  has_secure_password

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

  belongs_to :role, optional: true

  def admin?
    role.name == "Admin"
  end

  def referee?
    role.name == "Referee"
  end

  def sponsor?
    role.name == "Sponsor"
  end

  def official
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
end
