module ApplicationHelper
  def set_text_length_class(filter_name, length)
    {:class => (filter_name.length > length ? 'long' : '')}
  end

  def prepend_snowboard_crop(image_url)
     image_url.gsub!('upload/','upload/c_crop,g_north_west,w_954,h_5000/').html_safe
  end
end
