class ProductController < BaseController


  def index

    @category = A2::ProductCategory.find_by_slug(params[:category]) || not_found
    page @category.slug

    if stale?(:etag => create_etag([@category.updated_at, page.updated_at]))

      @feature_types = A2::ProductFeatureType.includes(:product_features).where(:id => @category.filters.split(',')) unless @category.filters.blank?
      @products = @category.products.visible.include_all # Rails.cache.fetch(@category) {  }

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

  def legacy
    product = A2::Product.cached_product_by_slug(params[:slug]) || not_found
    redirect_to product_show_url(:product => params[:slug],:category => product.categories[0].slug), status: :moved_permanently
  end


end
