class UserDecorator < BaseDecorator
  def name_with_avatar
    image_tag(object.avatar_url(:thumb), class: "ui avatar image") +
      "&nbsp;#{object.name}".html_safe
  end

  def display_name
    object.name.present? ? object.name : object.email
  end

  def email_display_name
    object.name.present? ? "#{object.name} <#{object.email}>" : object.email
  end
end
