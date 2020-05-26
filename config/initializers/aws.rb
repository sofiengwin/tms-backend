require 'aws-sdk-s3'

AWS_CREDENTIALS = Aws::Credentials.new(
  ENV['AWS_ACCESS_KEY'],
  ENV['AWS_ACCESS_SECRET'],
)

AWS_S3 = Aws::S3::Resource.new(
  region: 'us-east-1',
  credentials: AWS_CREDENTIALS,
)