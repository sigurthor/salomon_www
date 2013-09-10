module ProductHelper

  def get_size_variants
    unless @product.product_variants.length == 1
      render :partial => 'product_size_thumbs', :locals =>
      { :variants => @product.product_variants }
    end
  end

  def get_color_variants
    unless @product.product_color_variants.length == 1
      render :partial => 'product_color_thumbs',
             :locals => { :variants => @product.product_color_variants }
    end
  end

  def display_more_assets_link
    @number_of_assets = @product.assets.count
    unless @number_of_assets < 5
      @number_of_extra_assets = @number_of_assets - 4
      "<div class='more-images'><a href='#'><div>#{@number_of_extra_assets} other riders</div></a></div>".html_safe
    end
  end

  def display_more_riders_link
    @number_of_riders = @product.team_members.count
    unless @number_of_riders < 6
      @number_of_extra_riders = @number_of_riders - 5
      "<li class='more-riders'>#{@number_of_extra_riders} other riders</li>".html_safe
    end
  end

  def salomon_link(slug)

    locale = params[:locale].blank? ? params[:locale] : cookies[:locale]
    c = A2::Country.fetch_by_locale(locale)
    "#{Rails.application.config.salomon_url}#{c.salomon_locale}/product/#{slug}.html"
  end


end
