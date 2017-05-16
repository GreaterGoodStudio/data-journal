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
    when :error, :alert then "ui negative message"
    when :notice then "ui warning message"
    end
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to "#{sortable_icon(column)} #{title}".html_safe, sort: column, direction: direction
  end

  private

    def sortable_icon(column)
      # These are purposefully backwards--it just feels better/right
      css_class = if column == sort_column && sort_direction == "desc"
        "ascending"
      elsif column == sort_column && sort_direction == "asc"
        "descending"
      end
      "<i class=\"icon sort #{css_class}\"></i> "
    end
end
