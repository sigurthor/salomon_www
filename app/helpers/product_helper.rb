module ProductHelper

  def get_size_variants
    unless @product.product_variants.count == 1
      render :partial => 'product_size_thumbs', :locals =>
      { :variants => @product.product_variants }
    end
  end

  def get_color_variants
    unless @product.product_color_variants.count == 1
      render :partial => 'product_color_thumbs',
             :locals => { :variants => @product.product_color_variants }
    end
  end

end
