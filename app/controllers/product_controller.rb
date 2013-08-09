class ProductController < ApplicationController
  def index
    @products = A2::Product.all
  end

  def show
  end
end
