class Api::ConversionController < ApplicationController
  def convert
    converted_data = FormatConverter.new(
      permitted_params[:image_format],
      permitted_params[:base64_encoded_data],
      ENV['CONVERT_FORMAT']).convert
    render json: converted_data
  end

private

  def permitted_params
    params.permit(:image_format, :base64_encoded_data)
  end
end
