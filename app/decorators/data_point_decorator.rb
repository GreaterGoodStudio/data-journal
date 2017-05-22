class DataPointDecorator < BaseDecorator
  def member_bookmark
    path = object.bookmark_member? ? unbookmark_data_point_path(object) : bookmark_data_point_path(object)

    if policy(object).bookmark_member? && !policy(object).bookmark_moderator?
      link_to(bookmark_icon(object.bookmark_member?, true), path, method: :post, remote: true)
    elsif object.bookmark_member?
      bookmark_icon(object.bookmark_member?)
    end
  end

  def moderator_bookmark
    path = object.bookmark_moderator? ? unbookmark_data_point_path(object) : bookmark_data_point_path(object)

    policy(object).bookmark_moderator? ? link_to(bookmark_icon(object.bookmark_moderator?, true), path, method: :post, remote: true) : nil
  end

  private

    def bookmark_icon(selected, owner = false)
      selected_class = selected ? "" :  "remove"
      color_class = owner ? "blue" : "grey"
      content_tag(:i, nil, class: "large icon bookmark #{selected_class} #{color_class}")
    end
end
