# app/graphql/mutations/skip_user.rb
module Mutations
  class SkipUser < BaseMutation
    argument :user_id, ID, required: true
    argument :liked_user_id, ID, required: true

    field :match, Types::MatchType, null: true
    field :errors, [String], null: false

    def resolve(user_id:, liked_user_id:)
      user = User.find(user_id)
      liked_user = User.find(liked_user_id)

      match = Match.find_by(user: user, liked_user: liked_user)

      if match
        match.update(status: :skipped)
        { match: match, errors: [] }
      else
        { match: nil, errors: ['Match not found'] }
      end
    end
  end
end
