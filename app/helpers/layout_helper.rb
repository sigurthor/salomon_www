module LayoutHelper
  def gear_categories
    @menu_items ||= A2::ProductCategory.find_by_slug('salomon').descendants
  end
end