module ApplicationHelper
  def set_text_length_class(filter_name, length)
    {:class => (filter_name.length > length ? 'long' : '')}
  end
end
