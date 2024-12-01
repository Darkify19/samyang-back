class Mutations::RegisterUser < Mutations::BaseMutation
  argument :first_name, String, required: true
  argument :last_name, String, required: true
  argument :email, String, required: true
  argument :mobile_number, String, required: false 
  argument :birthdate, String, required: false 
  argument :gender, String, required: false 
  argument :sexual_orientation, String, required: false 
  argument :gender_interest, String, required: false 
  argument :location, String, required: false
  argument :bio, String, required: false 
  argument :password, String, required: true 
  argument :password_confirmation, String, required: true

  field :user, Types::UserType, null: true
  field :errors, [String], null: false

  def resolve(first_name:, last_name:, email:, mobile_number:, birthdate:, gender:, sexual_orientation:, gender_interest:, location:, bio:, password:, password_confirmation:)
    if password != password_confirmation
      return { user: nil, errors: ["Passwords do not match"] }
    end

    user = User.new(
      first_name: first_name,
      last_name: last_name,
      email: email,
      mobile_number: mobile_number.presence,  
      birthdate: birthdate.presence,          
      gender: gender.presence,                
      sexual_orientation: sexual_orientation.presence, 
      gender_interest: gender_interest.presence, 
      location: location.presence,           
      bio: bio.presence,                     
      password: password,
      password_confirmation: password     
    )

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
