class ProductController < BaseController
  def index
    @products = A2::Product.all
  end

  def show
  end
end
