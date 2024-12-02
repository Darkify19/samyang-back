module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :first_name, String, null: true
    field :last_name, String, null: true
    field :email, String, null: false
    field :mobile_number, String, null: true
    field :birthdate, String, null: true
    field :gender, String, null: true
    field :sexual_orientation, String, null: true
    field :gender_interest, String, null: false
    field :location, String, null: true
    field :bio, String, null: true
    field :admin, Boolean, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: true
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: true
    field :photos, [Types::PhotoType], null: true

    # Resolver method in UserType or the associated model
def photos
  object.photos.presence || []
end
  end
end
