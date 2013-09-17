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

    locale = params[:locale].blank? ? cookies[:locale] : params[:locale]
    puts "locale #{locale}"
    c = A2::Country.fetch_by_locale(locale)
    puts "salomon locale#{c.salomon_locale}"
    "#{Rails.application.config.salomon_url}#{c.salomon_locale}/product/#{slug}.html"
  end

  def set_asset_type(asset_type)
    if asset_type == 'A2::ImageAsset'
      {:class => 'vimeo'}
    elsif asset_type == 'A2::VideoAsset'
      {:class => 'product-image'}
    end
  end

  def set_lightbox_href(asset)
    if asset.type == 'A2::ImageAsset'
      {:href => cl_image_path(asset.img, :width => 1000, :height => 800, :crop => :fill), :title => asset.title, :data => {:group => 'product-media'}}
    elsif asset.type == 'A2::VideoAsset'
      {:href => "http://player.vimeo.com/video/" + asset.video_url + "?title=0&byline=0&portrait=0", :title => asset.title, :data => {:group => 'product-media'}}
    end

  end


end
