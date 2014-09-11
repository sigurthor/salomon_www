module ApplicationHelper
  def set_text_length_class(filter_name, length)
    {:class => (filter_name.length > length ? 'long' : '')}
  end

  def product_price(product)
    t :display_currency, scope: :salomon, price: product.price unless params[:locale].casecmp('en').zero?
  end

  def prepend_snowboard_crop(image_url)
    raw image_url.gsub!('upload/', 'upload/c_crop,g_north_west,w_954,h_5000/')
  end


  def is_current_locale(locale)
    I18n.locale.to_s.casecmp(locale).zero?
  end


  def img_loader
    haml_tag :div, :class => 'img-wrapper' do
      haml_tag :div, :class => 'loader' do
        haml_tag :div, :class => 'half left' do
          haml_tag :div, :class => 'band'
        end
        haml_tag :div, :class => 'half right' do
          haml_tag :div, :class => 'band'
        end
      end
      yield
    end
  end

end
