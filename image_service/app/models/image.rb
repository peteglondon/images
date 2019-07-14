class Image
  include Mongoid::Document
  field :image_format, type: String
  field :base64_encoded_data, type: String
end
