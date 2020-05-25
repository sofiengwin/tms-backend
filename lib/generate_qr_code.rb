require 'rqrcode'

class GenerateQrCode
  attr_reader :qrcode

  def initialize(str:)
    @qrcode = RQRCode::QRCode.new(str)
  end

  def file
    @qrcode.as_png(
      bit_depth: 4,
      border_modules: 2,
      color_mode: ChunkyPNG::COLOR_GRAYSCALE,
      color: 'black',
      file: nil,
      fill: 'white',
      module_px_size: 10,
      resize_exactly_to: false,
      resize_gte_to: false,
      size: 400
    ).to_s
  end
end