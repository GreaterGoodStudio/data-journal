class DataPointDecorator < BaseDecorator
  def member_bookmark
    icon_class = object.bookmark_member? ? "" : "remove"
    path = object.bookmark_member? ? unbookmark_data_point_path(object) : bookmark_data_point_path(object)
    bookmark_icon = content_tag(:i, nil, class: "large blue icon bookmark #{icon_class}")

    policy(object).bookmark_member? ? link_to(bookmark_icon, path, method: :post) : bookmark_icon
  end

  def moderator_bookmark
    icon_class = object.bookmark_moderator? ? "" : "remove"
    path = object.bookmark_moderator? ? unbookmark_data_point_path(object) : bookmark_data_point_path(object)
    bookmark_icon = content_tag(:i, nil, class: "large red icon bookmark #{icon_class}")

    policy(object).bookmark_moderator?  ? link_to(bookmark_icon, path, method: :post) : nil
  end
end