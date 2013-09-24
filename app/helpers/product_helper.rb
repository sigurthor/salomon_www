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
    unless @number_of_assets < 4
      @number_of_extra_assets = @number_of_assets - 3
      @asset_label = pluralize(@number_of_extra_assets, "more item")
      "<div class='more-images'><a href='#'><div> #{@asset_label}</div></a></div>".html_safe
    end
  end

  def display_more_riders_link
    @number_of_riders = @product.team_members.count
    unless @number_of_riders < 6
      @number_of_extra_riders = @number_of_riders - 5
      "<li class='more-riders'>#{@number_of_extra_riders} other " + pluralize(@number_of_extra_riders, "rider") + "</li>".html_safe
    end
  end

  def hide_buy_button?
    params[:locale].casecmp('en').zero?
  end

  def salomon_link(slug)
    c = A2::Country.find_by( :locale => I18n.locale.to_s)
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
