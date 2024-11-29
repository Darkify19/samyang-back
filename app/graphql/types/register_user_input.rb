module Types
  class RegisterUserInput < GraphQL::Schema::InputObject
    description "Input for registering a new user"
    
    argument :email, String, required: true
    argument :name, String, required: true
  end
end
9