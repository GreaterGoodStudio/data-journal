class ConsentFormUploader < BaseUploader
  include CarrierWaveDirect::Uploader

  version :thumb do
    process resize_and_pad: [200, 200, "#404040"]
  end

  version :large do
    process resize_to_limit: [800, 800]
  end
end
