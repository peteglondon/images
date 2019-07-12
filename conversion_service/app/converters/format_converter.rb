class FormatConverter
  def initialize(format, base64_data, convert_format)
    @format = format
    @base64_data = base64_data
    @convert_format = convert_format
  end

  def convert
    { image_format: convert_format, base64_encoded_data: convert_base_64 }
  end

private

  def convert_base_64
    image = MiniMagick::Image.read(Base64.strict_decode64(base64_data), format)
    image.format convert_format
    Base64.strict_encode64(image.to_blob)
  end

  attr_accessor :format, :base64_data, :convert_format
end
