class Mutations::SetPrimaryPhoto < Mutations::BaseMutation
  argument :user_id, ID, required: true
  argument :photo_id, ID, required: true

  field :success, Boolean, null: false
  field :errors, [String], null: true

  def resolve(user_id:, photo_id:)
    user = User.find(user_id)
    photo = user.photos.find(photo_id)

    return { success: false, errors: ["Photo not found"] } unless photo

    # Update the 'updated_at' of the selected photo
    photo.touch

    { success: true, errors: [] }
  rescue => e
    { success: false, errors: [e.message] }
  end
end
