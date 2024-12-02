# app/graphql/types/upload.rb
class Types::Upload < GraphQL::Schema::Scalar
  
  def self.coerce_input(value, _ctx)
    value # File upload object from the client
  end
  
    def self.coerce_result(value, context)
      # Return the file object after upload
      value
    end
  end
  