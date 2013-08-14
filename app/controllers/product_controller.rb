class ProductController < BaseController
  def index

    category = A2::ProductCategory.by_slug(params[:category]).first  #todo cache
    @products = category.products.includes(product_features: [:product_feature_type],product_color_variants: [:product_images])   #todo use scope

  end

  def show
  end
end
