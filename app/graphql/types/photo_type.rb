# app/graphql/types/photo_type.rb
module Types
    class PhotoType < Types::BaseObject
      field :url, String, null: true
  
      def url
        object.url if object.attached?
      end
    end
  end
  