class User < ApplicationRecord
  has_secure_password

  has_many :center_referee, class_name: "Fixture", foreign_key: "center_referee_id"
  has_many :right_side_referee, class_name: "Fixture", foreign_key: "right_side_referee_id"
  has_many :left_side_referee, class_name: "Fixture", foreign_key: "left_side_referee_id"

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

  def to_token_payload
    {
      sub: id,
      email: email,
      username: username,
      role: self.role.name
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
end
