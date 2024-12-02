module Mutations
  class CreateMatch < BaseMutation
    argument :user_id, ID, required: true
    argument :liked_user_id, ID, required: true
  
    field :match, Types::MatchType, null: false

    def resolve(user_id:, liked_user_id:)
      # Find the user by user_id
      user = User.find_by(id: user_id)
      raise GraphQL::ExecutionError, "User not found" unless user

      # Prevent duplicate match creation
      existing_match = Match.find_by(user_id: user.id, liked_user_id: liked_user_id)
      if existing_match
        raise GraphQL::ExecutionError, "You have already liked this user"
      end

      # Create the match
      match = Match.create!(user_id: user.id, liked_user_id: liked_user_id)

      { match: match }
    end
  end
end
