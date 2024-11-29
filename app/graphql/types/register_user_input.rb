module Types
  class RegisterUserInput < BaseInputObject
    argument :first_name, String, required: true
    argument :last_name, String, required: true
    argument :email, String, required: true
    argument :mobile_number, String, required: true
    argument :birthdate, String, required: true
    argument :gender, String, required: true
    argument :sexual_orientation, String, required: true
    argument :gender_interest, String, required: true
    argument :location, String, required: true
    argument :bio, String, required: true
    argument :photos, [String], required: false
  end
end
