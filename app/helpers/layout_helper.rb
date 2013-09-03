module LayoutHelper
  def gear_categories
    @menu_items = A2::ProductCategory.fetch_by_visible(true)
    #@menu_items ||= A2::ProductCategory.where(:visible => true).order(:position)
  end

  def regions
    @regions = A2::Region.fetch_by_visible(true)
  end
end