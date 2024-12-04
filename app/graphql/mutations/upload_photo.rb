# app/graphql/mutations/upload_photo.rb
class Mutations::UploadPhoto < Mutations::BaseMutation
  argument :user_id, ID, required: true
  argument :url, String, required: true

  field :photo, Types::PhotoType, null: true
  field :errors, [String], null: false

  def resolve(user_id:, url:)
    user = User.find(user_id)
    if user.photos.count >= 5
      return { photo: nil, errors: ["You can only upload up to 5 photos."] }
    end

    # Assign next position for the photo
    position = user.photos.maximum(:position).to_i + 1
    photo = user.photos.new(url: url, position: position)

    if photo.save
      { photo: photo, errors: [] }
    else
      { photo: nil, errors: photo.errors.full_messages }
    end
  end
end
