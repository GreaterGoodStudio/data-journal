class UserDecorator < BaseDecorator
  def name_with_avatar(possessive: false)
    name = possessive ? object.name.possessive : object.name
    image_tag(object.avatar_url(:thumb), class: "ui avatar image") +
      "&nbsp;#{name}".html_safe
  end

  def display_name
    object.name.present? ? object.name : object.email
  end

  def email_display_name
    object.name.present? ? "#{object.name} <#{object.email}>" : object.email
  end
end
