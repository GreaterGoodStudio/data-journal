CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:               "AWS",
    region:                 Rails.application.secrets.aws_region,
    aws_access_key_id:      Rails.application.secrets.aws_access_key_id,
    aws_secret_access_key:  Rails.application.secrets.aws_secret_access_key
  }
  config.fog_directory      = Rails.application.secrets.aws_s3_bucket
  config.use_action_status  = true
end
