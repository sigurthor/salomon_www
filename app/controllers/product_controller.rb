class ProductController < BaseController


  def index
    @category = A2::ProductCategory.by_slug(params[:category]).first  #todo cache
    @feature_types = A2::ProductFeatureType.includes(:product_features).where(:feature_type_code => @category.filters.split(','))
    @products = @category.products.includes(product_variants: [:product_image],product_features: [:product_feature_type],product_color_variants: [:product_images])   #todo use scope

  end

  def show
    @product = A2::Product.find_by_slug(params[:product])
  end
end
