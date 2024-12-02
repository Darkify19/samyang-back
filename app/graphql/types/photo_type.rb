module Types
  class PhotoType < Types::BaseObject
    field :url, String, null: true
    field :id, ID, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false

    def url
      object.file.attached? ? object.file.url : nil
    end
  end
end
