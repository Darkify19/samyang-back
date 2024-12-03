module Types
  class MatchType < BaseObject
    field :id, ID, null: false
    field :user_id, ID, null: false
    field :liked_user_id, ID, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :user, UserType, null: true  # user of the match
    field :liked_user, UserType, null: true  # matched user (liked_user)

    def user
      User.find(object.user_id)
    end
    
    def liked_user
      User.find(object.liked_user_id)
    end
  end
end
