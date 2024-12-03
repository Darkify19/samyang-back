module Mutations
  class DeleteUser < BaseMutation
    argument :id, ID, required: true

    field :success, Boolean, null: false
    field :errors, [String], null: true

    def resolve(id:)
      user = User.find_by(id: id)

      if user
        begin
          # Deleting associated matches (both sent and received)
          user.sent_matches.destroy_all
          user.received_matches.destroy_all
          
          # Attempt to destroy the user
          if user.destroy
            {
              success: true,
              errors: []
            }
          else
            {
              success: false,
              errors: user.errors.full_messages
            }
          end
        rescue => e
          # Catch any unexpected errors and log them
          {
            success: false,
            errors: ["An error occurred while deleting user: #{e.message}"]
          }
        end
      else
        {
          success: false,
          errors: ["User not found"]
        }
      end
    end
  end
end
