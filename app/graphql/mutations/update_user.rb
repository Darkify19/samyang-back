module Mutations
  class UpdateUser < BaseMutation
    # Define individual arguments for each field you want to update
    argument :id, ID, required: true
    argument :first_name, String, required: false
    argument :last_name, String, required: false
    argument :email, String, required: false
    argument :mobile_number, String, required: false
    argument :birthdate, GraphQL::Types::ISO8601Date, required: false
    argument :gender, String, required: false
    argument :sexual_orientation, String, required: false
    argument :gender_interest, String, required: false
    argument :location, String, required: false
    argument :bio, String, required: false

    # Define the fields returned by the mutation
    field :user, Types::UserType, null: true
    field :errors, [String], null: false

    def resolve(id:, **args)
      # Find the user by ID
      user = User.find_by(id: id)

      if user.nil?
        return { user: nil, errors: ["User not found"] }
      end

      # Update user attributes with the passed arguments
      if user.update(args)
        { user: user, errors: [] }
      else
        { user: nil, errors: user.errors.full_messages }
      end
    end
  end
end
