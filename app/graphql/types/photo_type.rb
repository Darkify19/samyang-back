module Types
  class PhotoType < Types::BaseObject
    field :id, ID, null: false
    field :url, String, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false

    def url
      object.url # Directly return the URL stored in the Photo model
    end
  end
end
