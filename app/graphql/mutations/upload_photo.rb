module Mutations
  class UploadPhoto < BaseMutation
    # Define individual arguments for user_id and file
    argument :user_id, ID, required: true
    argument :file, Types::Upload, required: true

    field :photo, Types::PhotoType, null: true
    field :errors, [String], null: false

    def resolve(user_id:, file:)
      user = User.find_by(id: user_id)
      return { photo: nil, errors: ["User not found"] } unless user
    
      photo = user.photos.build
    
      if file.present?
        photo.file.attach(io: file.to_io, filename: file.original_filename, content_type: file.content_type)
        if photo.save
          { photo: photo, errors: [] }
        else
          { photo: nil, errors: photo.errors.full_messages }
        end
      else
        { photo: nil, errors: ["No file uploaded"] }
      end
    end
    
    
    
  end
end
