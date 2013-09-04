class ProductController < BaseController


  def index

    @category = A2::ProductCategory.fetch_by_slug(params[:category]) || not_found
    page @category.slug

    if stale?(:etag => create_etag([@category.updated_at, page.updated_at]))

      @feature_types = A2::ProductFeatureType.includes(:product_features).where(:id => @category.filters.split(',')) unless @category.filters.blank?
      @products = Rails.cache.fetch(@category) { @category.products.include_all.all }

      respond_to do |f|
        f.html
      end
    end

  end

  def show
    @product = A2::Product.cached_product_by_slug(params[:product]) || not_found
    page "#{params[:category]}-product"

    if stale?(:etag => create_etag([@product.updated_at, page.updated_at]))
      respond_to do |f|
        f.html
      end
    end
  end


end
