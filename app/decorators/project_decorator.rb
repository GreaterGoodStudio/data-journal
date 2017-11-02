class ProjectDecorator < BaseDecorator
  def last_updated
    "#{h.time_ago_in_words(object.updated_at)} ago"
  end

  def activity_status
    return unless object.sessions.any?

    content_tag(:span, nil, class: "ui green empty horizontal circular label") +
      link_to("#{object.sessions.last.member.name} added a session&nbsp;".html_safe, session_path(object.sessions.last)) +
      content_tag(:strong, "#{time_ago_in_words(object.sessions.last.created_at)} ago")
  end

  def design_team
    (
      project.memberships.accepted.map { |m| linked_member_avatar(m.member, m.member.name) }.join +
      project.memberships.pending.map { |m| linked_member_avatar(m.member, "Invited: #{m.member.email}") }.join
    ).html_safe
  end

  # rubocop:disable Metrics/CyclomaticComplexity
  def due_date_status
    dd = project.due_date

    return if dd.blank? || dd < Date.today.beginning_of_day || dd > 3.weeks.from_now

    words_to_now = distance_of_time_in_words_to_now(project.due_date.end_of_day)
    date_in_words = case words_to_now
                    when "7 days" then "1 week"
                    when "14 days" then "2 weeks"
                    when "21 days" then "3 weeks"
                    else words_to_now
    end

    date_in_words = dd == Date.today ? "today" : "in #{date_in_words}"

    content_tag(:span, nil, class: "ui yellow empty horizontal circular label") +
      "Project data points are due ".html_safe +
      content_tag(:strong, date_in_words)
  end
  # rubocop:enable Metrics/CyclomaticComplexity

  private

    def linked_member_avatar(member, tooltip)
      path = member.invitation_accepted? ? project_member_path(object, member) : edit_project_path(object)
      link_to path, class: "ui avatar image", "data-tooltip" => tooltip do
        image_tag member.avatar_url(:thumb)
      end
    end
end
