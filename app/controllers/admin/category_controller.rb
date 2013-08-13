class Admin::CategoryController < ApplicationController

  layout false

  def assign_product_to_category
    cat_to_line = [['FB',3,'Bindings'],['SB',2,'Boards'],['CB',4,'Boots']]
    cat_to_line.each do |key,cat_id,cat_name|
      cat = A2::ProductCategory.find(cat_id)
      A2::Product.where(:product_line_code => key).each do |product|
        product.categories <<  cat unless product.categories.include? cat
        product.save if product.brand == cat.brand
      end
    end
  end
end
