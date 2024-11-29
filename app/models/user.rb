class User < ApplicationRecord
  # Removing photo-related associations for now
  # has_many :photos, dependent: :destroy
  # has_many_attached :photos

  # Keeping associations for matches and messages
  has_many :sent_matches, class_name: 'Match', foreign_key: 'user_id', dependent: :destroy
  has_many :received_matches, class_name: 'Match', foreign_key: 'liked_user_id', dependent: :destroy
  has_many :messages, dependent: :destroy

  # Using has_secure_password for authentication
  has_secure_password

  # Validations for the required fields
  validates :first_name, :last_name, :email, :mobile_number, :birthdate, :gender, :sexual_orientation, :gender_interest, :location, presence: true
  validates :email, uniqueness: true
  validates :password, length: { minimum: 6 }
end
