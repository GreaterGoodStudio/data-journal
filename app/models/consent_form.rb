class ConsentForm < ApplicationRecord
  mount_uploaders :images, ConsentFormUploader
end
