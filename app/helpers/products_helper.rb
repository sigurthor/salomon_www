module ProductsHelper
  def set_text_length_class(filter_name)
    {:class => (filter_name.length > 10 ? 'long' : '')}
  end
end