class BaseUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  process :fix_exif_rotation

  def fix_exif_rotation #this is my attempted solution
    manipulate! do |img|
      img.tap(&:auto_orient)
    end
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end
  alias_method :extension_white_list, :extension_whitelist

  def fog_public
    false
  end
end
