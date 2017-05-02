class ProjectDecorator < BaseDecorator
  def last_updated
    "#{h.time_ago_in_words(project.updated_at)} ago"
  end

  def activity_status
    return unless object.sessions.any?

    content_tag(:span, nil, class: "ui green empty horizontal circular label") +
      "#{object.sessions.last.member.name} added a session&nbsp;".html_safe +
      content_tag(:strong, "#{time_ago_in_words(object.sessions.last.created_at)} ago")
  end

  def design_team
    (
      project.memberships.accepted.map { |m| linked_member_avatar(m.member, m.member.name) }.join +
      project.memberships.pending.map { |m| linked_member_avatar(m.member, "Invited: #{m.member.email}") }.join
    ).html_safe
  end

  def due_date_status
    return unless project.due_date?

    content_tag(:span, nil, class: "ui yellow empty horizontal circular label") +
      "Project data points are due in&nbsp;".html_safe +
      content_tag(:strong, distance_of_time_in_words_to_now(project.due_date))
  end

  private

    def linked_member_avatar(member, tooltip)
      link_to "#", class: "ui avatar image", "data-tooltip" => tooltip do
        image_tag member.avatar_url(:thumb)
      end
    end
end
