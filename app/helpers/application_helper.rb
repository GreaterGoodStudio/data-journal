module ApplicationHelper
  def title(title)
    content_for :title, strip_tags(title)
  end

  def has_submenu?
    @project.present? && @submenu
  end

  def is_active?(path)
    current_page?(path)
  end

  def flash_class(level)
    case level.to_sym
    when :success then "ui positive message"
    when :error then "ui negative message"
    when :notice then "ui warning message"
    end
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, { sort: column, direction: direction }, class: css_class
  end
end
