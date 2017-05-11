class ConsentFormUploader < BaseUploader
  include CarrierWaveDirect::Uploader

  version :thumb do
    process resize_and_pad: [200, 200, "#404040"]
  end
end
