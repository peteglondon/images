require 'rails_helper'
describe 'image conversion' do
  let(:image_data) do
    {
      image: {
        image_format: 'jpg',
        base64_encoded_data: 'the-image-data'
      }
    }
  end
  let(:png_image_data) do
    {
      image: {
        image_format: 'png',
        base64_encoded_data: 'the-image-data'
      }
    }
  end

  before do
    post '/api/images', params: image_data
  end

  it 'returns the original image if no format' do
    get "/api/images/#{Image.first.id}"
    expect(successful_result).to eq(image_data.deep_stringify_keys)
  end

  it 'returns the original image if format is the same' do
    get "/api/images/#{Image.first.id}.jpg"
    expect(successful_result).to eq(image_data.deep_stringify_keys)
  end

  it 'calls the png service if asking for png' do
    req = stub_conversion_request('png')
    get "/api/images/#{Image.first.id}.png"
    expect(req).to have_been_made
  end

  it 'calls the gif service if asking for gif' do
    req = stub_conversion_request('gif')
    get "/api/images/#{Image.first.id}.gif"
    expect(req).to have_been_made
  end

  def successful_result
    expect(response.status).to eq(200)
    JSON.parse(response.body)
  end

  def stub_conversion_request(format)
    stub_request(:post, "http://#{format}:3001/api/convert")
      .with(
        body: image_data[:image].to_json,
        headers: { 'Content-Type' => 'application/json' }
      )
      .to_return(body: png_image_data[:image].to_json)
  end
end
