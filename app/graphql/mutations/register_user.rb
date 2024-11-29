class Mutations::RegisterUser < Mutations::BaseMutation
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
  argument :password, String, required: true  # Add password argument

  field :user, Types::UserType, null: true
  field :errors, [String], null: false

  def resolve(first_name:, last_name:, email:, mobile_number:, birthdate:, gender:, sexual_orientation:, gender_interest:, location:, bio:, password:)
    user = User.new(
      first_name: first_name,
      last_name: last_name,
      email: email,
      mobile_number: mobile_number,
      birthdate: birthdate,
      gender: gender,
      sexual_orientation: sexual_orientation,
      gender_interest: gender_interest,
      location: location,
      bio: bio,
      password: password  # Pass the password to the User model
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
