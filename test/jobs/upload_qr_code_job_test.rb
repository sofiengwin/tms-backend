require 'test_helper'

class UploadQrCodeJobTest < ActiveSupport::TestCase
  test 'success' do
    driver = create(:driver)
    stub_request(:put, "https://sofien-pizzas.s3.amazonaws.com/#{driver.id}-qr-code.png")
      .to_return(status: 200, body: "", headers: {})


    UploadQrCodeJob.new.perform(driver.id)
  end
end