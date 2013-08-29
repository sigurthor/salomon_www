class ProductController < BaseController


  def index
    @category = A2::ProductCategory.by_slug(params[:category]).first  #todo cache
    page @category.slug
    @feature_types = A2::ProductFeatureType.includes(:product_features).where(:id => @category.filters.split(',')) unless @category.filters.blank?
    @products = @category.products.includes(:categories, {product_color_variants: :product_images},{product_features: :product_feature_type},{product_variants: :product_image})   #todo use scope

  end

  def show
    page "#{params[:category]}-product"
    @product = A2::Product.find_by_slug(params[:product])
  end
end
