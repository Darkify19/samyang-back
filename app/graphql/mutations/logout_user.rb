class Mutations::LogoutUser < BaseMutation
    field :success, Boolean, null: false
  
    def resolve
      # Clear the session
      context[:session][:user_id] = nil
  
      # Optionally, you could add a message here
      { success: true }
    end
  end
  