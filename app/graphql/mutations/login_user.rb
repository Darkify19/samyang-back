module Mutations
  class LoginUser < BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true

    field :user, Types::UserType, null: true
    field :errors, [String], null: true

    def resolve(email:, password:)
        user = User.find_by(email: email)

      if user&.authenticate(password)
        # Store the user in session after successful login
        context[:session][:user_id] = user.id

        {
          user: user,
          errors: []
        }
      else
        {
          user: nil,
          errors: ['Invalid credentials']
        }
      end
    end
  end
end
