module Types
  class QueryType < BaseObject
    field :users, [Types::UserType], null: false, description: "Get all users"

  # This defines the `user` query to fetch a single user by their ID
  field :user, Types::UserType, null: false do
    argument :id, ID, required: true, description: "ID of the user to fetch"
  end

  # Resolver for the `users` query
  def users
    User.all # Or any other method to fetch users
  end
# Resolver for the `user` query by ID
def user(id:)
  User.find(id) # Fetch a user by ID
end
  end
end
