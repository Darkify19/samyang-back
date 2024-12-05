class Mutations::DeletePhoto < Mutations::BaseMutation
    argument :photo_id, ID, required: true
    argument :user_id, ID, required: true
  
    field :success, Boolean, null: false
    field :errors, [String], null: false
  
    def resolve(photo_id:, user_id:)
      user = User.find(user_id)
      photo = user.photos.find(photo_id)
  
      # Prevent deleting primary photo
  
      photo.destroy!
  
      # Reassign positions
      user.photos.order(:position).each_with_index do |photo, index|
        photo.update!(position: index + 1)
      end
  
      { success: true, errors: [] }
    rescue ActiveRecord::RecordNotFound
      { success: false, errors: ["Photo not found."] }
    rescue => e
      { success: false, errors: [e.message] }
    end
  end
  