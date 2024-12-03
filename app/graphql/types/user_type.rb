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
    field :matches, [Types::MatchType], null: true # Matches field

    def matches
      # Combine sent and received matches
      sent_matches = object.sent_matches.includes(:liked_user)
      received_matches = object.received_matches.includes(:user)
      sent_matches + received_matches # Concatenate both match lists
    end
  end
end
