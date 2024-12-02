module Types
  class MutationType < GraphQL::Schema::Object
    field :register_user, mutation: Mutations::RegisterUser
    field :login_user, mutation: Mutations::LoginUser
    field :updateUser, mutation: Mutations::UpdateUser
    field :upload_photo, mutation: Mutations::UploadPhoto
    field :create_match, mutation: Mutations::CreateMatch
  end
end
