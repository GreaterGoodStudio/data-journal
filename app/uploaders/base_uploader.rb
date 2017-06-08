class BaseUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  process :fix_exif_rotation
  process quality: 80

  def fix_exif_rotation #this is my attempted solution
    manipulate! do |img|
      img.tap(&:auto_orient)
    end
  end

  def quality(percentage)
    manipulate! do |img|
      img.tap { |i| i.quality(percentage) }
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
