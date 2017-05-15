class ConsentForm < ApplicationRecord
  mount_uploaders :images, ConsentFormUploader

  belongs_to :session
  has_one :member, through: :session
end
