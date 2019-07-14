class Api::ImagesController < ApplicationController
  def create
    image = Image.create(params[:image].permit(:image_format, :base64_encoded_data))
    render json: {
      status: 'ok',
      id: image.id.to_s
    }
  end

  def show
    image = Image.find(params[:id])
    render json: {
      image: {
          image_format: image.image_format,
          base64_encoded_data: image.base64_encoded_data
        }
      }
  end
end
