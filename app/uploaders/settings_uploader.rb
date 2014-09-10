class SettingsUploader < CarrierWave::Uploader::Base
  def store_dir
    'uploads/images/banners/'
  end

  def cache_dir
    'uploads/images/tmp/banners/'
  end
end