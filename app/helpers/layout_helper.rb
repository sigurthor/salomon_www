module LayoutHelper
  def gear_categories
    @menu_items ||= Rails.cache.fetch('product-category-meny',:tags => ['product_categories']) { A2::ProductCategory.cached_deceandans_of('salomon').all }
  end

  def regions
    @regions = A2::Region.where(:visible => true)
  end
end