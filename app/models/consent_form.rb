class ConsentForm < ApplicationRecord
  mount_uploaders :images, ConsentFormUploader

  belongs_to :session, counter_cache: true, touch: true
  has_one :project, through: :session
  has_one :member, through: :session

  def slug
    name.present? ? name.downcase.strip.tr(" ", "-").gsub(/[^\w-]/, "") : "consent_form_#{id}"
  end
end
