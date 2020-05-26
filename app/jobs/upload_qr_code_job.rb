class UploadQrCodeJob < ApplicationJob
  def perform(driver_id)
    driver = Driver.find(driver_id)
    UploadQrCode.new.upload(
      driver_id: driver.id,
      file: GenerateQrCode.new(str: driver.mot_number).file,
    )
    
    driver.update!(qr_code: "https://#{ENV['QR_CODE_BUCKET']}.s3.amazonaws.com/#{driver.id}-qr-code.png")
  end
end