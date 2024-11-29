module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :first_name, String, null: true
    field :last_name, String, null: true
    field :email, String, null: true
    field :mobile_number, String, null: true
    field :birthdate, String, null: true
    field :gender, String, null: true
    field :sexual_orientation, String, null: true
    field :gender_interest, String, null: true
    field :location, String, null: true
    field :bio, String, null: true
    field :photos, [String], null: true  # List of URLs or paths to photos
  end
end
