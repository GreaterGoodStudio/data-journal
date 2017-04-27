class PhotoUploader < CarrierWave::Uploader::Base
  include CarrierWaveDirect::Uploader
  include CarrierWave::MiniMagick

  version :thumb do
    process resize_to_fill: [200, 200]
  end

  version :large do
    process resize_to_fill: [500, 500]
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end
  alias_method :extension_white_list, :extension_whitelist

  def fog_public
    false
  end

  def default_url(*_args)
    "http://placehold.it/500x500?text=placeholder" if Rails.env.development?
  end
end
