class Api::ConversionController < ApplicationController
  def convert
    converted_data = FormatConverter.new(
      params[:image_format],
      params[:base64_encoded_data],
      ENV['CONVERT_FORMAT']).convert
    render json: converted_data
  end
end
