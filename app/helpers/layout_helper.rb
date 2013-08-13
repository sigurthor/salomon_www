module LayoutHelper
  def gear_menu
    @menu_items ||= A2::ProductCategory.all
  end
end