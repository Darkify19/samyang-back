# app/graphql/mutations/upload_photo.rb
class Mutations::UploadPhoto < Mutations::BaseMutation
  argument :user_id, ID, required: true
  argument :url, String, required: true
  argument :is_primary, Boolean, required: false, default_value: false  # Add this line to handle isPrimary

  field :photo, Types::PhotoType, null: true
  field :errors, [String], null: false

  def resolve(user_id:, url:, is_primary: false)  # Update the method signature
    user = User.find(user_id)

    if user.photos.count >= 5
      return { photo: nil, errors: ["You can only upload up to 5 photos."] }
    end

    # Assign next position for the photo
    position = user.photos.maximum(:position).to_i + 1
    photo = user.photos.new(url: url, position: position)

    # If the photo is marked as primary, set all existing photos to non-primary
    if is_primary
      user.photos.update_all(is_primary: false)
    end

    if photo.save
      photo.update(is_primary: is_primary) if is_primary  # Only set as primary if the flag is true
      { photo: photo, errors: [] }
    else
      { photo: nil, errors: photo.errors.full_messages }
    end
  end
end
