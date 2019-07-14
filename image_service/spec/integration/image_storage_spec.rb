require 'rails_helper'

describe 'image storage and retrieval' do
  it 'stores and retrieves the image' do
    request_body = {
      image: {
        image_format: 'jpg',
        base64_encoded_data: 'the-image-data'
      }
    }
    post '/api/images', params: request_body
    expect(response.status).to eq(200)
    result = JSON.parse(response.body)
    expect(result['status']).to eq('ok')
    get "/api/images/#{result['id']}"

    expect(response.status).to eq(200)
    expect(JSON.parse(response.body)).to eq(request_body.deep_stringify_keys)
  end
end
