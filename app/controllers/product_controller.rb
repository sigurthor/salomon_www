class ProductController < BaseController


  def index
    @category = A2::ProductCategory.fetch_by_slug(params[:category])
    page @category.slug
    @feature_types = A2::ProductFeatureType.includes(:product_features).where(:id => @category.filters.split(',')) unless @category.filters.blank?
    @products = Rails.cache.fetch(@category){ @category.products.include_all.all }

  end

  def show
    page "#{params[:category]}-product"
    @product = A2::Product.cached_product_by_slug(params[:product])
  end
end
