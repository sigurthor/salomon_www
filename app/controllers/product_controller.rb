class ProductController < BaseController


  def index
    @category = A2::ProductCategory.fetch_by_slug(params[:category])
    page @category.slug

    if stale?(:etag => [@category.updated_at, page.updated_at].join(''))

      @feature_types = A2::ProductFeatureType.includes(:product_features).where(:id => @category.filters.split(',')) unless @category.filters.blank?
      @products = Rails.cache.fetch(@category) { @category.products.include_all.all }

      respond_to do |f|
        f.html
      end
    end

  end

  def show

    @product = A2::Product.cached_product_by_slug(params[:product])
    page "#{params[:category]}-product"

    if stale?(:etag => [@product.updated_at, page.updated_at].join(''))
      respond_to do |f|
        f.html
      end
    end
  end
end
