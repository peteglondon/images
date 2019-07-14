class ConversionService
  def self.for(format)
    new(format)
  end

  def initialize(format)
    @format = format
  end

  def call(image_data)
    json = HTTParty.post(convert_url, body: image_data.to_json, headers: { 'Content-Type' => 'application/json' }).body
    JSON.parse(json)
  end

private

  def convert_url
    "http://#{@format}:3001/api/convert"
  end
end
