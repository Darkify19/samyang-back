module Mutations
  class RegisterUser < BaseMutation
    argument :email, String, required: true
    argument :name, String, required: true

    field :user, Types::UserType, null: false
    field :errors, [String], null: false

    def resolve(email:, name:)
      user = User.new(email: email, name: name)

      if user.save
        {
          user: user,
          errors: []
        }
      else
        {
          user: nil,
          errors: user.errors.full_messages
        }
      end
    end
  end
end
