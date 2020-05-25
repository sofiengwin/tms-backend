require 'aws-sdk-s3'

AWS_CREDENTIALS = Aws::Credentials.new(
  'AKIAJ46ODZE7A3NRYKHQ',
  '7Mpo05UmSrmewAPyF9HITy8vWmEcY1mU4ZJAq/hc',
)

AWS_S3 = Aws::S3::Resource.new(
  region: 'us-east-1',
  credentials: AWS_CREDENTIALS,
)