module Types
    class UpdateUserInput < BaseInputObject
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
    end
  end
  