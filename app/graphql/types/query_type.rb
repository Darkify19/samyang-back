module Types
  class QueryType < BaseObject
    field :users, [Types::UserType], null: false, description: "Get all users"
    
    field :users_by_gender_interest, [Types::UserType], null: false, description: "Get users filtered by gender interest" do
      argument :gender_interest, String, required: false # Change required: true to false (nullable)
    end
    
    field :user, Types::UserType, null: false do
      argument :id, ID, required: true, description: "ID of the user to fetch"
    end

    field :matches, [Types::MatchType], null: false, description: "Fetch all matches for the current user" do
      argument :user_id, ID, required: true
    end

    def users
      User.all
    end

    def user(id:)
      User.find(id)
    end

    def users_by_gender_interest(gender_interest: nil)
      if gender_interest.blank? || gender_interest == "Any"
        users = User.all
      else
        users = User.where(gender: gender_interest)  # Filter by 'gender' field, not 'gender_interest'
      end
    end
    
    def matches(user_id:)
      matches = Match
        .where("user_id = ? AND liked_user_id IN (?)", user_id, Match.where(liked_user_id: user_id).pluck(:user_id))
        .includes(:user, :liked_user)
        .distinct
    
      Rails.logger.debug "Fetched mutual matches: #{matches.inspect}"  # Log the fetched matches for debugging
      matches
    end
  end
end
