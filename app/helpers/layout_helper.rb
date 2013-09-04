module LayoutHelper
  def gear_categories
    @menu_items = A2::ProductCategory.fetch_by_visible_and_type(true,'A2::ProductCategory')
  end

  def regions
    @regions = A2::Region.fetch_by_visible(true)
  end
end