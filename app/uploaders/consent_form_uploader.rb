class ConsentFormUploader < CarrierWave::Uploader::Base
  include CarrierWaveDirect::Uploader
  include CarrierWave::MiniMagick

  version :thumb do
    process resize_and_pad: [200, 200, "#404040"]
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end
  alias_method :extension_white_list, :extension_whitelist

  def fog_public
    false
  end
end
