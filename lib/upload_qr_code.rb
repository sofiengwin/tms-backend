class UploadQrCode
  def upload(driver_id:, file:)
    bucket.object("#{driver_id}-qr-code.png").put(body: file)
  end

  private def bucket
    AWS_S3.bucket('sofien-pizzas')
  end
end