module Types
  class MutationType < GraphQL::Schema::Object
    field :register_user, mutation: Mutations::RegisterUser
    field :login_user, mutation: Mutations::LoginUser
    field :updateUser, mutation: Mutations::UpdateUser
    field :upload_photo, mutation: Mutations::UploadPhoto
    field :create_match, mutation: Mutations::CreateMatch
    field :delete_user, mutation: Mutations::DeleteUser
    field :delete_photo, mutation: Mutations::DeletePhoto
    field :set_primary_photo, mutation: Mutations::SetPrimaryPhoto
  end
end
