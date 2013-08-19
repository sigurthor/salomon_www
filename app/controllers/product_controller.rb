class ProductController < BaseController


  def index
    @category = A2::ProductCategory.by_slug(params[:category]).first  #todo cache
    @feature_types = A2::ProductFeatureType.includes(:product_features).where(:id => @category.filters.split(',')) unless @category.filters.blank?
    @products = @category.products.includes({product_color_variants: :product_images},{product_features: :product_feature_type},{product_variants: :product_image})   #todo use scope

  end

  def show
    @product = A2::Product.includes({product_color_variants: :product_images},{product_features: :product_feature_type},{product_variants: :product_image},{product_variants: {tech_specifications: :tech_definition}}).where(:slug => params[:product]).limit(1).first
  end
end
