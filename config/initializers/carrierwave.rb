CarrierWave.configure do |config|
  
  # Use local storage if in development or test
  if Rails.env.development? || Rails.env.test?
    CarrierWave.configure do |config|
      config.storage = :file
    end
  end

  config.fog_credentials = {
    :provider               => 'AWS',                             # required
    :aws_access_key_id      => ENV["AWS_ACCESS_KEY"],             # required
    :aws_secret_access_key  => ENV["AWS_SECRET_KEY"],             # required
  }
  config.fog_directory  = ENV["AWS_BUCKET"]                       # required

  # Use AWS storage if in production

  if Rails.env.production?
    CarrierWave.configure do |config|
      config.storage = :fog
    end
  end
end