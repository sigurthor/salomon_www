module LayoutHelper
  def gear_categories
    @menu_items ||= A2::ProductCategory.cached_deceandans_of('salomon')
  end

  def regions
    @regions = A2::Region.where(:visible => true)
  end
end