module Types
  class QueryType < BaseObject
    field :users, [UserType], null: false

    def users
      User.all
    end
  end
end
