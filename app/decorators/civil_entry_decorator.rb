class CivilEntryDecorator < Draper::Decorator
  delegate_all
  def created_at_formatted
    created_at.strftime(format_string)
  end

  private
  
  def format_string
    '%B %e, %Y'
  end
end
