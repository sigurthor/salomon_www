module LayoutHelper
  def gear_categories
    @menu_items ||= A2::ProductCategory.where(:visible => true).order(:position)
  end
end