module LayoutHelper
  def gear_categories
    @menu_items ||= A2::ProductCategory.where(:visible => true).order(:position)
  end

  def regions
    @regions ||= A2::Region.all
  end
end