require 'rails_helper'

describe 'image conversion' do

  context 'when the service is running in png mode' do
    before do
      ENV['CONVERT_FORMAT'] = 'png'
    end

    it 'converts the image' do
      request_body = {
        image_format: 'jpg',
        base64_encoded_data: read_test_image_as_base64('icon.jpg')
      }
      post '/api/convert', params: request_body
      expect(response.status).to eq(200)
      result = JSON.parse(response.body)
      expect(result['image_format']).to eq('png')
      expect(result['base64_encoded_data'].length).to eq(read_test_image_as_base64('icon.png').length)
    end
  end

  context 'when the service is running in gif mode' do
    before do
      ENV['CONVERT_FORMAT'] = 'gif'
    end

    it 'converts the image' do
      request_body = {
        image_format: 'jpg',
        base64_encoded_data: read_test_image_as_base64('icon.jpg')
      }
      post '/api/convert', params: request_body
      expect(response.status).to eq(200)
      result = JSON.parse(response.body)
      expect(result['image_format']).to eq('gif')
      expect(result['base64_encoded_data'].length).to eq(read_test_image_as_base64('icon.gif').length)
    end
  end

  def read_test_image_as_base64(file_name)
    path = File.join(Rails.root, 'spec', 'fixtures', file_name)
    File.open(path) do |img|
      Base64.strict_encode64(img.read)
    end
  end
end
