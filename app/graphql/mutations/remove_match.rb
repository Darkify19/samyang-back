# app/graphql/mutations/remove_match.rb
module Mutations
    class RemoveMatch < BaseMutation
      argument :liked_user_id, ID, required: true
  
      field :match, Types::MatchType, null: false
  
      def resolve(liked_user_id:)
        current_user = context[:current_user]
        match = Match.find_by(user_id: current_user.id, liked_user_id: liked_user_id)
        match.destroy if match
  
        { match: match }
      end
    end
  end
  