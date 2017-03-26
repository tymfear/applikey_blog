module ApplicationHelper
  def edit_action?
    action_name.eql? 'edit'
  end
  
  def error_badges(record)
    record.errors.full_messages.map do |message|
      error_badge_span message
    end.join.html_safe
  end
  
  def error_badge_span(message)
    content_tag :span, message, class: %w(badge badge-pill badge-danger)
  end
  
  def user_avatar(user)
    return if user.avatar_data.nil?
    
    image_tag user.avatar_data, alt: 'User avatar', class: "avatar-thumb"
  end
end
