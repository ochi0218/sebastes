CarrierWave.configure do |config|
  unless Rails.env.development? || Rails.env.test?
    config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => ENV['AWS_S3_KEY_ID'],
      :aws_secret_access_key  => ENV['AWS_S3_SECRET_KEY'],
      :region                 => 'ap-northeast-1'
    }
    config.fog_directory  = ENV['AWS_S3_BUCKET']
    config.fog_public     = false
    config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}
  end

  def cache_dir
    "#{Rails.root}/tmp/uploads"
  end
end
