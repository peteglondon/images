class Api::ImagesController < ApplicationController
  def create
    image = Image.create(params[:image].permit(:image_format, :base64_encoded_data))
    render json: {
      status: 'ok',
      id: image.id.to_s
    }
  end

  def show
    render json: image_or_converted
  end

private

  def image
    @image ||= Image.find(params[:id])
  end

  def image_or_converted
    return convert_image unless same_format_requested?
    {
      image: {
        image_format: image.image_format,
        base64_encoded_data: image.base64_encoded_data
      }
    }
  end

  def convert_image
    {
      image: ConversionService.for(format).call(
        image_format: image.image_format,
        base64_encoded_data: image.base64_encoded_data
      )
    }

  end

  def same_format_requested?
    format.nil? || format == image.image_format
  end

  def format
    params[:format]
  end
end
