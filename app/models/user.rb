class User < ApplicationRecord
  # Password authentication (requires bcrypt)
  has_secure_password  # Adds methods like .authenticate to check password validity

  # Associations
  has_many :sent_matches, class_name: 'Match', foreign_key: 'user_id', dependent: :destroy
  has_many :received_matches, class_name: 'Match', foreign_key: 'liked_user_id', dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :photos

  # Validations
  validates :first_name, :last_name, :email, :mobile_number, :birthdate, :gender, :sexual_orientation, :gender_interest, :location, presence: true
  validates :email, uniqueness: true
  validates :password, length: { minimum: 6 }, presence: true, on: :create  # Ensure password is required only on create

  # Validate password only when creating a user
  validates :password, presence: true, on: :create
  
  # Custom validation for password update
  validate :password_required_on_create, on: :create

  def photo_urls
    self.photos.map(&:url).presence || ['/assets/default_placeholder.png'] # Assuming Photo model has a `url` column
  end

  private

  def password_required_on_create
    if self.new_record? && self.password.blank?
      errors.add(:password, "can't be blank")
    end
  end
end
