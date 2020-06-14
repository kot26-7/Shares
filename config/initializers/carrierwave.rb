unless Rails.env.development? || Rails.env.test?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['AWS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_SECRET_KEY'],
      region: 'ap-northeast-1'
    }

    config.fog_directory  = ENV['FOG_DIRECTORY']
    config.cache_storage = :fog
  end
end