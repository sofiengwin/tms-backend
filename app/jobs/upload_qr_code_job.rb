class UploadQrCodeJob < ApplicationJob
  def perform(driver_id)
    driver = Driver.find(driver_id)
    UploadQrCode.new.upload(
      driver_id: driver.id,
      file: GenerateQrCode.new(str: driver.mot_number).file,
    )
  end
end